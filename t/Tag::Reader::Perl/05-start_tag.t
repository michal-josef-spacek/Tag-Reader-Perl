# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 16;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Debug message.
print "Testing: Start of tag.\n";

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/start_tag1.tags');
my @tag = $obj->gettoken;
is($tag[0], '<tag>');
is($tag[1], 'tag');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/start_tag2.tags');
@tag = $obj->gettoken;
is($tag[0], '<tag:color>');
is($tag[1], 'tag:color');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/start_tag3.tags');
@tag = $obj->gettoken;
is($tag[0], '<tag attr="param">');
is($tag[1], 'tag');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/start_tag4.tags');
@tag = $obj->gettoken;
is($tag[0], '<tag attr="param" />');
is($tag[1], 'tag');
is($tag[2], 1);
is($tag[3], 1);
