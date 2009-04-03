#------------------------------------------------------------------------------
package Tag::Reader::Perl;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use Readonly;

# Constants.
Readonly::Scalar my $EMPTY_STR => q{};

# Version.
our $VERSION = '0.01';

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Show errors.
	$self->{'set_errors'} = 0;

	# Process params.
	while (@params) {
		my $key = shift @params;
		my $val = shift @params;
		if (! exists $self->{$key}) {
			err "Unknown parameter '$key'.";
		}
		$self->{$key} = $val;
	}

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub set_text {
#------------------------------------------------------------------------------
# Set text.

	my ($self, $text, $force) = @_;
	if (! $text) {
		err 'Bad text.';
	}
	if (! $force && (defined $self->{'text'}
		|| defined $self->{'filename'})) {

		err 'Cannot set new data if exists data.';
	}
	$self->{'text'} = $text;

	# Reset values.
	$self->_reset;

	return;
}

#------------------------------------------------------------------------------
sub set_file {
#------------------------------------------------------------------------------
# Set file.

	my ($self, $file, $force) = @_;
	if (! $file || ! -r $file) {
		err 'Bad file.';
	}
	if (! $force && (defined $self->{'text'}
		|| defined $self->{'filename'})) {

		err 'Cannot set new data if exists data.';
	}
	my $inf;
	if (! open $inf, '<', $file) {
		err "Cannot open file '$file'.";
	}
	$self->{'filename'} = $inf;

	# Reset values.
	$self->_reset;

	return;
}

#------------------------------------------------------------------------------
sub gettoken {
#------------------------------------------------------------------------------
# Get tag token.

	my $self = shift;

	# Stay.
	$self->{'stay'} = 0;
	$self->{'spec_stay'} = 0;
	$self->{'old_stay'} = 0;

	# Data.
	$self->{'data'} = [];

	# Tag type.
	$self->{'tag_type'} = 'data';
	$self->{'tag_length'} = 0;

	# Braces.
	($self->{'brace'}, $self->{'bracket'}) = (0, 0);

	# Quote.
	$self->{'quote'} = $EMPTY_STR;

	# Tag line.
	$self->{'tagline'} = $self->{'textline'};
	$self->{'tagcharpos'} = 0;

	if (exists $self->{'text'}) {
		while (exists $self->{'text'}
			&& $self->{'stay'} < 98
			&& defined ($self->{'char'}
			= substr($self->{'text'}, 0, 1))) {

			$self->_gettoken;
		}
	} elsif (exists $self->{'filename'}) {
		while ($self->{'stay'} < 98
			&& ((defined ($self->{'char'}
			= shift @{$self->{'old_data'}}))
			|| (defined ($self->{'char'}
			= getc($self->{'filename'}))))) {

			$self->_gettoken;
		}
	}

	my $data = join($EMPTY_STR, @{$self->{'data'}});
	if ($data eq $EMPTY_STR) {
		return ();
	}
	return wantarray ? ($data, $self->{'tag_type'}, $self->{'tagline'},
		$self->{'tagcharpos'}) : $data;
}

#------------------------------------------------------------------------------
# Private functions and methods.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _reset {
#------------------------------------------------------------------------------
# Reset class values.

	my $self = shift;

	# Default values.
	$self->{'charpos'} = 0;
	$self->{'tagcharpos'} = 0;
	$self->{'textline'} = 1;
	$self->{'tagline'} = 0;
	$self->{'old_data'} = [];

	return;
}

#------------------------------------------------------------------------------
sub _gettoken {
#------------------------------------------------------------------------------
# Main get token.

	my $self = shift;

	# Char position.
	$self->{'charpos'}++;

	# Normal tag.
	if ($self->{'spec_stay'} == 0) {

		# Begin of normal tag.
		if ($self->{'stay'} == 0 && $self->{'char'} eq '<') {

			# In tag.
			if ($#{$self->{'data'}} == -1) {
				$self->{'tagcharpos'}
					= $self->{'charpos'};
				$self->{'stay'} = 1;
				push @{$self->{'data'}}, $self->{'char'};
				$self->{'tag_length'} = 1;

			# Start of tag, after data.
			} else {
				$self->{'stay'} = 99;
			}

		# Text.
		} elsif ($self->{'stay'} == 0) {
			push @{$self->{'data'}}, $self->{'char'};
			if ($self->{'tagcharpos'} == 0) {
				$self->{'tagcharpos'}
					= $self->{'charpos'};
			}

		# In a normal tag.
		} elsif ($self->{'stay'} == 1) {

			# End of normal tag.
			if ($self->{'char'} eq '>') {
				$self->{'stay'} = 98;
				$self->_tag_type;
				push @{$self->{'data'}}, $self->{'char'};
				$self->{'tag_length'} = 0;

			# First charcter after '<' in normal tag.
			} elsif ($self->{'tag_length'} == 1
				&& _is_first_char_of_tag($self->{'char'})) {

				if ($self->{'char'} eq q{!}) {
					$self->{'spec_stay'} = 1;
				}
				push @{$self->{'data'}}, $self->{'char'};
				$self->{'tag_length'}++;

			# Next character in normal tag (name).
			} elsif ($self->{'tag_length'} > 1
				&& _is_in_tag_name($self->{'char'})) {

				push @{$self->{'data'}}, $self->{'char'};
				$self->{'tag_length'}++;

			# Other characters.
			} else {
				if ($self->{'tag_length'} == 1
					|| $self->{'char'} eq '<') {

					err 'Bad tag.';
				}
				$self->_tag_type;
				push @{$self->{'data'}}, $self->{'char'};
			}
		}

	# Other tags.
	} else {

		# End of normal tag.
		if ($self->{'char'} eq '>') {
			if (($self->{'brace'} == 0
				&& $self->{'bracket'} == 0
				&& $self->{'spec_stay'} < 3)

				# Comment.
				|| ($self->{'spec_stay'} == 3
				&& join($EMPTY_STR,
				@{$self->{'data'}}[-2 .. -1])
				eq q{--})

				# CDATA.
				|| ($self->{'tag_type'} =~ /^!\[cdata\[/ms
				&& join($EMPTY_STR,
				@{$self->{'data'}}[-2 .. -1])
				eq ']]')) {

				$self->{'stay'} = 98;
				$self->{'spec_stay'} = 0;
				$self->{'tag_length'} = 0;
			}
			if ($self->{'spec_stay'} != 4) {
				$self->{'bracket'}--;
			}
			push @{$self->{'data'}}, $self->{'char'};

		# Comment.
		} elsif ($self->{'spec_stay'} == 3) {

			# '--' is bad.
			if ($self->{'tag_length'} == 0
				&& join($EMPTY_STR, @{$self->{'data'}}
				[-2 .. -1]) eq q{--}) {

				err 'Bad tag.';
			}
			$self->_tag_type;
			push @{$self->{'data'}}, $self->{'char'};

		# Quote.
		} elsif ($self->{'spec_stay'} == 4) {
			if ($self->{'char'} eq $self->{'quote'}) {
				$self->{'spec_stay'} = $self->{'old_stay'};
				$self->{'quote'} = $EMPTY_STR;
			}
			push @{$self->{'data'}}, $self->{'char'};

		} elsif ($self->{'char'} eq ']') {
			push @{$self->{'data'}}, $self->{'char'};
			$self->{'brace'}--;

		# Next character in normal tag (name).
		} elsif ($self->{'tag_length'} > 1
			&& _is_in_tag_name($self->{'char'})) {

			# Comment detect.
			if (($self->{'tag_length'} == 2
				|| $self->{'tag_length'} == 3)
				&& $self->{'char'} eq q{-}) {

				$self->{'spec_stay'}++;
			}
			if ($self->{'char'} eq '[') {
				$self->{'brace'}++;
			}
			push @{$self->{'data'}}, $self->{'char'};
			$self->{'tag_length'}++;

		# Other characters.
		} else {
			if ($self->{'quote'} eq $EMPTY_STR
				&& $self->{'char'} eq q{"}) {

				$self->{'quote'} = q{"};
				$self->{'old_stay'} = $self->{'spec_stay'};
				$self->{'spec_stay'} = 4;
			}
			if ($self->{'quote'} eq $EMPTY_STR
				&& $self->{'char'} eq q{'}) {

				$self->{'quote'} = q{'};
				$self->{'old_stay'} = $self->{'spec_stay'};
				$self->{'spec_stay'} = 4;
			}
			if ($self->{'char'} eq '<') {
				$self->{'bracket'}++;
			}
			if ($self->{'char'} eq '[') {
				$self->{'brace'}++;
			}
			$self->_tag_type;
			push @{$self->{'data'}}, $self->{'char'};
		}
	}

	# Remove char from buffer.
	if ($self->{'stay'} != 99) {
		if (exists $self->{'text'}) {
			if (length $self->{'text'} > 1) {
				$self->{'text'} = substr($self->{'text'}, 1);
			} else {
				delete $self->{'text'};
			}
		}
	} else {
		if (exists $self->{'filename'}
			&& defined $self->{'char'}) {

			push @{$self->{'old_data'}}, $self->{'char'};
		}
	}
	if ($self->{'stay'} == 98 || $self->{'stay'} == 99) {
		if ($self->{'stay'} == 99) {
			$self->{'charpos'}--;
		}
	}

	# Next line.
	if ($self->{'char'} eq "\n") {
		$self->{'textline'}++;
		$self->{'charpos'} = 0;
	}

	return;
}

#------------------------------------------------------------------------------
sub _is_first_char_of_tag {
#------------------------------------------------------------------------------
# First character in tag.

	my $char = shift;
	if ($char eq q{!} || $char eq q{/} || $char eq q{?}
		|| $char =~ /^[\d\w]+$/ms) {

		return 1;
	}
	return 0;
}

#------------------------------------------------------------------------------
sub _is_in_tag_name {
#------------------------------------------------------------------------------
# Normal characters in a tag name.

	my $char = shift;
	if ($char eq q{:} || $char eq '[' || $char eq q{-} || $char eq q{%}
		|| $char =~ /^[\d\w]+$/ms) {

		return 1;
	}
	return 0;
}

#------------------------------------------------------------------------------
sub _tag_type {
#------------------------------------------------------------------------------
# Process tag type.

	my $self = shift;
	if ($self->{'tag_length'} > 0) {
		$self->{'tag_type'}
			= lc(join($EMPTY_STR, @{$self->{'data'}}
			[1 .. $self->{'tag_length'} - 1]));
		$self->{'tag_length'} = 0;
	}
	return;
}

1;

