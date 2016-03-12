# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 8;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('end_element1.sgml')->s);
my @tag = $obj->gettoken;
is($tag[0], "</element>");
is($tag[1], "/element");
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('end_element2.sgml')->s);
@tag = $obj->gettoken;
is($tag[0], "</element:color>");
is($tag[1], "/element:color");
is($tag[2], 1);
is($tag[3], 1);
