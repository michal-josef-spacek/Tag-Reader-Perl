# Test directory.
my $test_dir = "$ENV{'PWD'}/t/Tag::Reader::Perl";

# Modules.
use Tag::Reader::Perl;
use Test::More 'tests' => 12;

print "Testing: Instruction tag.\n";
my $obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/instruction1.tags');
my @tag = $obj->gettoken;
is($tag[0], "<?xml?>");
is($tag[1], "?xml");
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/instruction2.tags');
@tag = $obj->gettoken;
is($tag[0], "<?xml version=\"1.0\"?>");
is($tag[1], "?xml");
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/instruction3.tags');
@tag = $obj->gettoken;
is($tag[0], "<?application This is normal sentence.\nAnd second sentence.?>");
is($tag[1], "?application");
is($tag[2], 1);
is($tag[3], 1);
