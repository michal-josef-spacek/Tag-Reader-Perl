# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 40;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Debug message.
print "Testing: Element test.\n";

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/element1.tags');
my @tag = $obj->gettoken;
is($tag[0], '<!ELEMENT br EMPTY>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/element2.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT p (#PCDATA|emph)* >');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/element3.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT %name.para; %content.para; >');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/element4.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT container ANY>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/element5.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT spec (front, body, back?)>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/element6.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT div1 (head, (p | list | note)*, div2)>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/element7.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT dictionary-body (%div.mix; | %dict.mix;)*>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/element8.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT p (#PCDATA|a|ul|b|i|em)*>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/element9.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT p (#PCDATA | %font; | %phrase; | %special; | %form;)* >');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/element10.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT b (#PCDATA)>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);
