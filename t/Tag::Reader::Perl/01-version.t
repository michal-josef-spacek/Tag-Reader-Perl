# Modules.
use Tag::Reader::Perl;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($Tag::Reader::Perl::VERSION, '0.01');
