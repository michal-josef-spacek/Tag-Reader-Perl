#------------------------------------------------------------------------------
package Tag::Reader::Perl;
#------------------------------------------------------------------------------
# $Id: Perl.pm,v 1.13 2005-08-27 17:52:18 skim Exp $

# Pragmas.
use strict;

# Modules.
use Error::Simple qw(err);

# Version.
our $VERSION = '0.01';

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my $class = shift;
	my $self = bless {}, $class;

	# Show errors.
	$self->{'set_errors'} = 0;

	# Process params.
	while (@_) {
		my $key = shift;
		my $val = shift;
		err "Unknown parameter '$key'." if ! exists $self->{$key};
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
		err "Bad text.";
	}
	if (! $force && defined $self->{'text'}) {
		err "Cannot set text if exists text.";
	}
	$self->{'text'} = $text;

	# Default values.
	$self->{'charpos'} = 0;
	$self->{'tagcharpos'} = 0;
	$self->{'textline'} = 1;
	$self->{'tagline'} = 0;
}

#------------------------------------------------------------------------------
sub set_file {
#------------------------------------------------------------------------------
# Set file.

	my ($self, $file, $force) = @_;
	if (! $file || ! -r $file) {
		err "Bad file.";
	}
	if (! $force && defined $self->{'text'}) {
		err "Cannot set text if exists text.";
	}
	if (! open(INF, "<$file")) {
		err "Cannot read file \"$file\".";
	}
	foreach (<INF>) {
		$self->{'text'} .= $_;
	}

	# Default values.
	$self->{'charpos'} = 0;
	$self->{'tagcharpos'} = 0;
	$self->{'textline'} = 1;
	$self->{'tagline'} = 0;
}

#------------------------------------------------------------------------------
sub gettoken {
#------------------------------------------------------------------------------
# Get tag token.

	my $self = shift;

	# Stay.
	my $stay = 0;
	my $spec_stay = 0;
	my $old_stay = 0;
	my $comment_stay = 0;

	# Data.
	$self->{'data'} = [];

	# Tag type.
	$self->{'tag_type'} = 'data';
	$self->{'tag_length'} = 0;

	# Braces.
	my ($brace, $bracket) = (0, 0);

	# Quote.
	my $quote = '';

	# Tag line.
	$self->{'tagline'} = $self->{'textline'};
	$self->{'tagcharpos'} = 0;

	# Foreach chars.
	while (defined $self->{'text'} 
		&& defined (my $char = substr($self->{'text'}, 0, 1))) { 

		# Char position.
		$self->{'charpos'}++;

		# Normal tag.
		if ($spec_stay == 0) {

			# Begin of normal tag.
			if ($stay == 0 && $char eq '<') {

				# In tag.
				if ($#{$self->{'data'}} == -1) {
					$self->{'tagcharpos'} 	
						= $self->{'charpos'};
					$stay = 1;
					push @{$self->{'data'}}, $char;
					$self->{'tag_length'} = 1;

				# Start of tag, after data.
				} else {
					$stay = 99;
				}

			# Text.
			} elsif ($stay == 0) {
				push @{$self->{'data'}}, $char;
				if ($self->{'tagcharpos'} == 0) {
					$self->{'tagcharpos'} 
						= $self->{'charpos'};
				}

			# In a normal tag.
			} elsif ($stay == 1) {

				# End of normal tag.
				if ($char eq '>') {
					$stay = 98;
					$self->_tag_type;
					push @{$self->{'data'}}, $char;
					$self->{'tag_length'} = 0;

				# First charcter after '<' in normal tag.
				} elsif ($self->{'tag_length'} == 1 
					&& _is_first_char_of_tag($char)) {

					if ($char eq '!') {
						$spec_stay = 1;
					}
					push @{$self->{'data'}}, $char;
					$self->{'tag_length'}++;

				# Next character in normal tag (name).
				} elsif ($self->{'tag_length'} > 1
					&& _is_in_tag_name($char)) {

					push @{$self->{'data'}}, $char;
					$self->{'tag_length'}++;

				# Other characters.
				} else {
					if ($self->{'tag_length'} == 1 
						|| $char eq '<') {

						err "Bad tag.";
					}
					$self->_tag_type;
					push @{$self->{'data'}}, $char;
				}
			}

		# Other tags.
		} else {

			# End of normal tag.
			if ($char eq '>') { 
				if (($brace == 0 && $bracket == 0
					&& $spec_stay < 3) 

					# Comment.
					|| ($spec_stay == 3 
					&& join('', 
					@{$self->{'data'}}[-2 .. -1]) 
					eq '--')

					# CDATA.
					|| ($self->{'tag_type'} =~ /^!\[cdata\[/
					&& join('', 
					@{$self->{'data'}}[-2 .. -1]) 
					eq ']]')) {

					$stay = 98;
					$spec_stay = 0;
					$self->{'tag_length'} = 0;
				}
				if ($spec_stay != 4) {
					$bracket--;
				}
				push @{$self->{'data'}}, $char;

			# Comment.
			} elsif ($spec_stay == 3) {

				# '--' is bad.
				if ($self->{'tag_length'} == 0
					&& join('', @{$self->{'data'}}
					[-2 .. -1]) eq '--') {

					err "Bad tag.";
				}
				$self->_tag_type;
				push @{$self->{'data'}}, $char;

			# Quote.
			} elsif ($spec_stay == 4) {
				if ($char eq $quote) {
					$spec_stay = $old_stay;
					$quote = '';
				}
				push @{$self->{'data'}}, $char;

			} elsif ($char eq ']') {
				push @{$self->{'data'}}, $char;
				$brace--;

			# Next character in normal tag (name).
			} elsif ($self->{'tag_length'} > 1
				&& _is_in_tag_name($char)) {

				# Comment detect.
				if (($self->{'tag_length'} == 2
					|| $self->{'tag_length'} == 3)
					&& $char eq '-') {
				
					$spec_stay++;
				}
				if ($char eq '[') {
					$brace++;
				}
				push @{$self->{'data'}}, $char;
				$self->{'tag_length'}++;

			# Other characters.
			} else {
				if ($quote eq '' && $char eq '"') {
					$quote = '"';
					$old_stay = $spec_stay;
					$spec_stay = 4;
				}
				if ($quote eq '' && $char eq "'") {
					$quote = "'";
					$old_stay = $spec_stay;
					$spec_stay = 4;
				}
				if ($char eq '<') {
					$bracket++;
				}
				if ($char eq '[') {
					$brace++;
				}
				$self->_tag_type;
				push @{$self->{'data'}}, $char;
			}
		}

		# Remove char from buffer.
		if ($stay != 99) {
			if (length $self->{'text'} > 1) {
				$self->{'text'} = substr($self->{'text'}, 1);
			} else {
				$self->{'text'} = undef;
			}
		}
		if ($stay == 98 || $stay == 99) {
			if ($stay == 99) {
				$self->{'charpos'}--;
			}
			last;
		}

		# Next line.
		if ($char eq "\n") {
			$self->{'textline'}++;
			$self->{'charpos'} = 0;
		}
	}
	my $data = join('', @{$self->{'data'}});
	return () if $data eq '';
	return wantarray ? ($data, $self->{'tag_type'}, $self->{'tagline'}, 
		$self->{'tagcharpos'}) : $data;
}

#------------------------------------------------------------------------------
# Private functions.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _is_first_char_of_tag {
#------------------------------------------------------------------------------
# First character in tag.

	my $char = shift;
	if ($char eq '!' || $char eq '/' || $char eq '?' 
		|| $char =~ /^[\d\w]+$/) {

		return 1;
	}
	return 0;
}

#------------------------------------------------------------------------------
sub _is_in_tag_name {
#------------------------------------------------------------------------------
# Normal characters in a tag name.

	my $char = shift;
	if ($char eq ':' || $char eq '[' || $char eq '-' || $char eq '%'
		|| $char =~ /^[\d\w]+$/) {

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
			= lc(join('', @{$self->{'data'}}
			[1 .. $self->{'tag_length'} - 1]));
		$self->{'tag_length'} = 0;
	}
}

1;

