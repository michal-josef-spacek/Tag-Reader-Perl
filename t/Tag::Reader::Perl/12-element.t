# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 40;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element1.tags')->s);
my @tag = $obj->gettoken;
is($tag[0], '<!ELEMENT br EMPTY>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element2.tags')->s);
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT p (#PCDATA|emph)* >');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element3.tags')->s);
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT %name.para; %content.para; >');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element4.tags')->s);
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT container ANY>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element5.tags')->s);
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT spec (front, body, back?)>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element6.tags')->s);
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT div1 (head, (p | list | note)*, div2)>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element7.tags')->s);
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT dictionary-body (%div.mix; | %dict.mix;)*>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element8.tags')->s);
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT p (#PCDATA|a|ul|b|i|em)*>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element9.tags')->s);
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT p (#PCDATA | %font; | %phrase; | %special; | %form;)* >');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element10.tags')->s);
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT b (#PCDATA)>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);
