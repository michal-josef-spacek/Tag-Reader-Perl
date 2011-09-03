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
$obj->set_file($data_dir->file('instruction1.tags')->s);
my @tag = $obj->gettoken;
is($tag[0], "<?xml?>");
is($tag[1], "?xml");
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('instruction2.tags')->s);
@tag = $obj->gettoken;
is($tag[0], "<?xml version=\"1.0\"?>");
is($tag[1], "?xml");
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('instruction3.tags')->s);
@tag = $obj->gettoken;
is($tag[0], "<?application This is normal sentence.\nAnd second sentence.?>");
is($tag[1], "?application");
is($tag[2], 1);
is($tag[3], 1);
