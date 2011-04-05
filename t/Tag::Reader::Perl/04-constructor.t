# Modules.
use English qw(-no_match_vars);
use Tag::Reader::Perl;
use Test::More 'tests' => 4;

# Debug message.
print "Testing: Constructor.\n";

# Test.
eval {
	Tag::Reader::Perl->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

# Test.
eval {
	Tag::Reader::Perl->new('something' => 'value');
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n");

# Test.
my $obj = Tag::Reader::Perl->new;
ok(defined $obj);
ok($obj->isa('Tag::Reader::Perl'));
