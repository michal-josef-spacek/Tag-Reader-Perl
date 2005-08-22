#------------------------------------------------------------------------------
package Tag::Reader::Perl;
#------------------------------------------------------------------------------
# $Id: Perl.pm,v 1.6 2005-08-22 00:50:38 skim Exp $

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

	# Filename.
	$self->{'filename'} = shift;

	# Process params.
	while (@_) {
		my $key = shift;
		my $val = shift;
		err "Unknown parameter '$key'." if ! exists $self->{$key};
		$self->{$key} = $val;
	}

	# Check filename.
	if (! $self->{'filename'}) {
		err "Filename must be a string scalar.";
	}
	if (! open(INF, "<$self->{'filename'}")) {
		err "Can not read file \"$self->{'filename'}\".";
	}
	foreach (<INF>) {
		$self->{'text'} .= $_;
	}

	# Default values.
	$self->{'charpos'} = 0;
	$self->{'tagcharpos'} = 0;
	$self->{'fileline'} = 1;
	$self->{'tagline'} = 0;

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub gettoken {
#------------------------------------------------------------------------------
# Get tag token.

	my ($self, $showerrors) = @_;

	# Check file.
	if (! $self->{'fileline'}) {
		err "Object not initialized.";
	}

	# Stay.
	my $stay = 0;
	my $spec_stay = 0;
	my $comment_stay = 0;

	# Data.
	$self->{'data'} = [];

	# Tag type.
	$self->{'tag_type'} = 'data';
	$self->{'tag_length'} = 0;

	# Braces.
	my ($brace, $bracket) = (0, 0);

	# Tag line.
	$self->{'tagline'} = $self->{'fileline'};
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
					|| ($spec_stay == 3 
					&& join('', 
					@{$self->{'data'}}[-2 .. -1]) 
					eq '--')) {

					$stay = 98;
					$spec_stay = 0;
					$self->{'tag_length'} = 0;
				}
				$bracket--;
				push @{$self->{'data'}}, $char;

			# Comment.
			} elsif ($spec_stay == 3) {
				$self->_tag_type;
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
			$self->{'fileline'}++;
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

