# Modules.
use Test::More 'tests' => 2;

BEGIN {
	print "Usage tests.\n";
	use_ok('Tag::Reader::Perl');
}
require_ok('Tag::Reader::Perl');
