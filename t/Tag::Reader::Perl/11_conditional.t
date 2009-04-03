# Test directory.
my $test_dir = "$ENV{'PWD'}/t/Tag::Reader::Perl";

# Modules.
use Tag::Reader::Perl;
use Test::More 'tests' => 8;

print "Testing: Conditional test.\n";
my $obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/conditional1.tags');
my @tag = $obj->gettoken;
is($tag[0], '<![%foo[<!ELEMENT foo EMPTY>]]>');
is($tag[1], '![%foo[');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/conditional2.tags');
@tag = $obj->gettoken;
is($tag[0], '<![ %foo [<!ELEMENT foo EMPTY>]]>');
is($tag[1], '![');
is($tag[2], 1);
is($tag[3], 1);
