#------------------------------------------------------------------------------
package Tag::Reader::Perl;
#------------------------------------------------------------------------------
# $Id: Perl.pm,v 1.1 2005-08-20 06:00:01 skim Exp $

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
	if (! open($self->{'fd'}, "<$self->{'filename'}") {
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
	if ($ch eq '!' || $ch eq '/' || ch eq '?' || ch =~ /^[[:allnum:]]$/) {

		return 1;
	}
	return 0;
}

#------------------------------------------------------------------------------
sub is_in_tag {
#------------------------------------------------------------------------------
# Normal characters in a tag.

	my $ch = shift;
	if ($ch eq ':' || $ch eq '[' || isALNUM(ch)) {
		return 1;
	}
	return 0;
}

1;

