# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 12;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('comment1.sgml')->s);
my @tag = $obj->gettoken;
is($tag[0], "<!-- comment -->");
is($tag[1], "!--");
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('comment2.sgml')->s);
@tag = $obj->gettoken;
is($tag[0], "<!-- <tag> text </tag> -->");
is($tag[1], "!--");
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('comment3.sgml')->s);
@tag = $obj->gettoken;
is($tag[0], "<!-- <<<< comment <> -->");
is($tag[1], "!--");
is($tag[2], 1);
is($tag[3], 1);
