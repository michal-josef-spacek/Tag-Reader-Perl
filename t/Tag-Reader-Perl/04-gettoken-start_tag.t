# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 16;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('start_tag1.sgml')->s);
my @tag = $obj->gettoken;
is($tag[0], '<tag>');
is($tag[1], 'tag');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('start_tag2.sgml')->s);
@tag = $obj->gettoken;
is($tag[0], '<tag:color>');
is($tag[1], 'tag:color');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('start_tag3.sgml')->s);
@tag = $obj->gettoken;
is($tag[0], '<tag attr="param">');
is($tag[1], 'tag');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('start_tag4.sgml')->s);
@tag = $obj->gettoken;
is($tag[0], '<tag attr="param" />');
is($tag[1], 'tag');
is($tag[2], 1);
is($tag[3], 1);
