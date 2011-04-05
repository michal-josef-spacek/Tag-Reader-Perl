# Modules.
use English qw(-no_match_vars);
use Tag::Reader::Perl;
use Test::More 'tests' => 4;

print "Testing: Constructor.\n";
eval {
	Tag::Reader::Perl->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

eval {
	Tag::Reader::Perl->new('something' => 'value');
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n");

my $obj = Tag::Reader::Perl->new;
ok(defined $obj);
ok($obj->isa('Tag::Reader::Perl'));
