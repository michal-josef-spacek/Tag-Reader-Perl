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
$obj->set_file($data_dir->file('conditional1.tags')->s);
my @tag = $obj->gettoken;
is($tag[0], '<![%foo[<!ELEMENT foo EMPTY>]]>');
is($tag[1], '![%foo[');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('conditional2.tags')->s);
@tag = $obj->gettoken;
is($tag[0], '<![ %foo [<!ELEMENT foo EMPTY>]]>');
is($tag[1], '![');
is($tag[2], 1);
is($tag[3], 1);
