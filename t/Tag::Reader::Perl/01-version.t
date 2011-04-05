# Modules.
use Tag::Reader::Perl;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: version.\n";

# Test.
is($Tag::Reader::Perl::VERSION, '0.01');
