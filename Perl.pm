#------------------------------------------------------------------------------
package Tag::Reader::Perl;
#------------------------------------------------------------------------------
# $Id: Perl.pm,v 1.2 2005-08-20 08:28:10 skim Exp $

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
	$self->{'filename'} = '';

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
	if (! open($self->{'fd'}, "<$self->{'filename'}")) {
		err "Can not read file \"$self->{'filename'}\".";
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

	my $self = shift;
	my $showerrors = shift;

	# Check file.
	if (! $self->{'fileline'}) {
		err "Object not initialized.";
	}

	my $state = 0;
	my $substate = 0;
	my $bufpos = 0;
	my $typeposdone = 0;
	my $typepos = 0;
	my $brace_num = 0;
	my $bracket_num = 0;
	$self->{'tagline'} = $self->{'fileline'};
	my $ch = '';
	my $chn = '';

	# Find the next tag.
	while ($state != 3 && ($chn = getc($self->{'fd'})) != *EOF) {
		$self->{'charpos'}++;

		# Read one more character ahead so we have always 2. 
		if (! $ch) { 
			$ch = $chn;
#			continue;
			next;
		}
		if ($ch == '\n') {
			$self->{'fileline'}++;
			$self->{'charpos'} = 0;
		}
		$self->{'buffer'}->[$bufpos] = $ch;
		$bufpos++;

		# Outside of tag and we start tag here.
		if ($state == 0) {
			$self->{'tagcharpos'} = $self->{'charpos'};

			# Start tag.
			if ($ch eq '<') {
				if (is_start_of_tag($chn)) { 

					# We will be reading a tag.
					$state = 1;
				} else {
					
					# We will be reading a text/paragraph. 
					$state = 2; 

					# Warning.
					warn "$self->{'filename'}:".
						"$self->{'fileline'}:".
						"$self->{'charpos'}: ".
						"Warning, single ".
						"\'<\' should ".
						"be written as &lt;\n"
						if $showerrors;
				}

			# We will be reading a text/paragraph.
			} else {
				$state = 2;
			}

		# Stay for inside a tag. Wait for '>'.
		} elsif ($state == 1) {
			if ($typeposdone == 0) {
				
				if ((is_start_of_tag($ch) && $typepos == 0) 
					|| is_in_tag($ch)) {
						
					$self->{'tagtype'}->[$typepos] = ul($ch);
					$typepos++;
			
					# CDATA detection.
					if ($substate == 1 
						&& $self->{'tagtype'} 
						eq '![cdata[') {
						
						# Cdata stay.
						$state = 40;

						# Revert substate. 
						$substate = 0;
						
						# Symbol for cdata. 
						$self->{'tagtype'} = '<!CDATA[';
						$typepos = 9;
					}
				} else {
					# End of tag type e.g "<a " -> save 
					# only "a" in tagtype array.
					# $self->{'tagtype'}->[$typepos] = 0;

					# Mark end.
					$typeposdone = 1;
				}
			}

			# Bad start of tag. 
			if ($ch eq '<') {
				if ($substate == 1) {
					$brace_num++;
					
				} elsif ($showerrors) {
					err "$self->{'filename'}:".
						"$self->{'fileline'}: ".
						"Warning, single \'<\' or tag ".
						"starting at line ".
						"$self->{'tagline'} not terminated\n";
				}
			}

			# End of tag detection.
			if ($ch eq '>') {

				# Done reading this tag.
				if ($brace_num == 0 && $bracket_num == 0) {
					$state = 3;
				}
				if ($substate == 1 && $brace_num > 0) {
					$brace_num--;
				}
			}

			# Comment detection.
			if ($substate == 0 && $ch eq '!' && $chn eq '-' 
				&& $bufpos > 1 
				&& $self->{'buffer'}->[$bufpos - 2] == '<') {

				# Start of comment handling.
				$state = 30; 
				
				# Some comments are <!-----, but we want 
				# always the same tagtype for all comments:
				$self->{'tagtype'} = '!--';
				$typepos = 3;
			}

			if ($substate == 0 && $ch eq '!') {
				# TODO Doctype.
			}
			
			if ($chn eq '[') {

				# Start of special '<!['
				if ($ch == '!' && $bufpos > 1 && $substate == 0
					&& $self->{'buffer'}->[$bufpos - 2] eq '<') {

					$substate = 1;

				# Start doctype subdoc. 
				} else {
					$bracket_num++;
				}
			}
			
			# End doctype subdoc. 
			if ($substate == 1 && $chn eq ']' && $bracket_num > 0) {
				$bracket_num--;
			}

		# Inside a text. Wait for start of tag.
		} elsif ($state == 2) {
			if ($ch eq '>' && $showerrors) {
				warn "$self->{'filename'}:".
					"$self->{'fileline'}:".
					"$self->{'charpos'}: Warning, single ".
					"\'>\' should be written as ".
					"&gt;\n";
			}
			if ($ch eq '<') {

				# First char.
				if (is_start_of_tag($chn)) {

					# Put the start of tag back, we want to
					# return only the text part.
					$self->{'charpos'}--;
#					if (PerlIO_ungetc(self->fd, 
#						chn) == EOF) {
						
#						PerlIO_printf(PerlIO_stderr(),
#							"%s:%d: ERROR, "
#							"Tag::Reader library "
#							"can not ungetc "
#							"\"%c\"\n",
#							self->filename,
#							self->fileline, chn);
#						exit(1);
#					}
					$chn = $ch;
					$bufpos--;
					$state = 3;
				} else {

					# We will be reading 
					# a text/paragraph.
					$state = 2;
					if ($showerrors) {
						warn "$self->{'filename'}:".
							"$self->{'fileline'}:".
							"$self->{'charpos'}: ".
							"Warning, ".
							"single \'<\' should ".
							"be written as &lt;\n";
					}
				}
			}

		# Comment handling, we have found "<!--", wait for comment 
		# termination with "->".
		} elsif ($state == 30) {
			if ($ch eq '-' && $chn eq '>') {

				# Done reading this comment tag just get the 
				# closing '>'.
				$state = 99;
			}
	
		# End.
		} elsif ($state == 99) {
			$state = 3;

		# Cdata stay.
		} elsif ($state == 40) {

			# Cdata handling, we have found "<![CDATA[", wait for 
			# cdata termination with "]]>". 
			if ($ch eq ']' && $chn eq '>') {

				# Done reading this cdata tag just get the 
				# closing '>'.
				$state = 99;
			}

		# Bad stay.
		} else {
			err "$self->{'filename'}:$self->{'fileline'}: Programm 
				Error, state = $state\n";
			exit 1;
		}

		# Shift this and next char.
		$ch = $chn;
	}

	if ($chn == *EOF) {

		# Put the last char (ch) in the buffer.
		if ($ch) {
			$self->{'buffer'}->[$bufpos] = $ch;
			$bufpos++;
		}
	} else {

		# Put back chn for the next round.
		$self->{'charpos'}--;
#		if (PerlIO_ungetc(self->fd, chn) == EOF) {
#			PerlIO_printf(PerlIO_stderr(), "%s:%d: ERROR, "
#				"Tag::Reader library can not ungetc \"%c\" "
#				"before returning\n", self->filename, 
#				self->fileline, chn);
			exit 1;
#		}
	}

	if ($bufpos > 0) {

		# We have a tag or text and we return it.
		return wantarray ? ($self->{'buffer'}, $self->{'tagtype'}, 
			$self->{'tagline'}, $self->{'tagcharpos'}) 
			: $self->{'buffer'};
	} else {

		# We are at the end of the file and no tag was found 
		# return an empty list or string such that the user 
		# will probably call destroy. 
		return ();
	}
}

#------------------------------------------------------------------------------
sub DESTROY {
#------------------------------------------------------------------------------
# Destroy object.

	my $self = shift;
	close($self->{'fd'});
}

#------------------------------------------------------------------------------
# Private functions.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub is_start_of_tag {
#------------------------------------------------------------------------------
# TODO

	my $ch = shift;
	if ($ch eq '!' || $ch eq '/' || $ch eq '?' || $ch =~ /^[:allnum:]+$/) {

		return 1;
	}
	return 0;
}

#------------------------------------------------------------------------------
sub is_in_tag {
#------------------------------------------------------------------------------
# Normal characters in a tag.

	my $ch = shift;
	if ($ch eq ':' || $ch eq '[' || $ch =~ /^[:allnum:]+$/) {
		return 1;
	}
	return 0;
}

1;

