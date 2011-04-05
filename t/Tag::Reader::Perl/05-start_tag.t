# Modules.
use Tag::Reader::Perl;
use Test::More 'tests' => 16;

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/Tag::Reader::Perl";

print "Testing: Start of tag.\n";
my $obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/start_tag1.tags');
my @tag = $obj->gettoken;
is($tag[0], '<tag>');
is($tag[1], 'tag');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/start_tag2.tags');
@tag = $obj->gettoken;
is($tag[0], '<tag:color>');
is($tag[1], 'tag:color');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/start_tag3.tags');
@tag = $obj->gettoken;
is($tag[0], '<tag attr="param">');
is($tag[1], 'tag');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/start_tag4.tags');
@tag = $obj->gettoken;
is($tag[0], '<tag attr="param" />');
is($tag[1], 'tag');
is($tag[2], 1);
is($tag[3], 1);
