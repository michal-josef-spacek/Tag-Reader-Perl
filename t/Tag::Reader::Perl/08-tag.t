# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 64;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Debug message.
print "Testing: Tags example.\n";

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/tag1.tags');
my @tag = $obj->gettoken;
is($tag[0], "<text>");
is($tag[1], "text");
is($tag[2], 1);
is($tag[3], 1);
@tag = $obj->gettoken;
is($tag[0], 'text');
is($tag[1], 'data');
is($tag[2], 1);
is($tag[3], 7);
@tag = $obj->gettoken;
is($tag[0], '</text>');
is($tag[1], '/text');
is($tag[2], 1);
is($tag[3], 11);
@tag = $obj->gettoken;
is($tag[0], "\n");
is($tag[1], 'data');
is($tag[2], 1);
is($tag[3], 18);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/tag2.tags');
@tag = $obj->gettoken;
is($tag[0], "<text:color>");
is($tag[1], "text:color");
is($tag[2], 1);
is($tag[3], 1);
@tag = $obj->gettoken;
is($tag[0], 'text');
is($tag[1], 'data');
is($tag[2], 1);
is($tag[3], 13);
@tag = $obj->gettoken;
is($tag[0], '</text:color>');
is($tag[1], '/text:color');
is($tag[2], 1);
is($tag[3], 17);
@tag = $obj->gettoken;
is($tag[0], "\n");
is($tag[1], 'data');
is($tag[2], 1);
is($tag[3], 30);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/tag3.tags');
@tag = $obj->gettoken;
is($tag[0], "<text>");
is($tag[1], "text");
is($tag[2], 1);
is($tag[3], 1);
@tag = $obj->gettoken;
is($tag[0], '<![CDATA[<text>text</text>]]>');
is($tag[1], '![cdata[');
is($tag[2], 1);
is($tag[3], 7);
@tag = $obj->gettoken;
is($tag[0], '</text>');
is($tag[1], '/text');
is($tag[2], 1);
is($tag[3], 36);
@tag = $obj->gettoken;
is($tag[0], "\n");
is($tag[1], 'data');
is($tag[2], 1);
is($tag[3], 43);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/tag4.tags');
@tag = $obj->gettoken;
is($tag[0], "<x>");
is($tag[1], "x");
is($tag[2], 1);
is($tag[3], 1);
@tag = $obj->gettoken;
is($tag[0], '<![CDATA[a<x>b]]]>');
is($tag[1], '![cdata[a');
is($tag[2], 1);
is($tag[3], 4);
@tag = $obj->gettoken;
is($tag[0], '</x>');
is($tag[1], '/x');
is($tag[2], 1);
is($tag[3], 22);
@tag = $obj->gettoken;
is($tag[0], "\n");
is($tag[1], 'data');
is($tag[2], 1);
is($tag[3], 26);
