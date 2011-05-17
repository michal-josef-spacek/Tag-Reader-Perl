# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 8;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/end_tag1.tags');
my @tag = $obj->gettoken;
is($tag[0], "</tag>");
is($tag[1], "/tag");
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/end_tag2.tags');
@tag = $obj->gettoken;
is($tag[0], "</tag:color>");
is($tag[1], "/tag:color");
is($tag[2], 1);
is($tag[3], 1);
