# Modules.
use Test::Pod::Coverage 'tests' => 1;

print "Testing: Pod coverage.\n";
pod_coverage_ok('Tag::Reader::Perl', 'Tag::Reader::Perl is covered.');
