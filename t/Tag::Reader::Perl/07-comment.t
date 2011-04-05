# Modules.
use Tag::Reader::Perl;
use Test::More 'tests' => 12;

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/Tag::Reader::Perl";

print "Testing: Comment tag.\n";
my $obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/comment1.tags');
my @tag = $obj->gettoken;
is($tag[0], "<!-- comment -->");
is($tag[1], "!--");
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/comment2.tags');
@tag = $obj->gettoken;
is($tag[0], "<!-- <tag> text </tag> -->");
is($tag[1], "!--");
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/comment3.tags');
@tag = $obj->gettoken;
is($tag[0], "<!-- <<<< comment <> -->");
is($tag[1], "!--");
is($tag[2], 1);
is($tag[3], 1);
