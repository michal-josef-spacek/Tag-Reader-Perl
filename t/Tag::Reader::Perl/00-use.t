# Modules.
use Test::More 'tests' => 2;

BEGIN {

	# Debug message.
	print "Usage tests.\n";

	# Test.
	use_ok('Tag::Reader::Perl');
}

# Test.
require_ok('Tag::Reader::Perl');
