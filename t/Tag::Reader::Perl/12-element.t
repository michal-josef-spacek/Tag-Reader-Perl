# Modules.
use Tag::Reader::Perl;
use Test::More 'tests' => 40;

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/Tag::Reader::Perl";

print "Testing: Element test.\n";
my $obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/element1.tags');
my @tag = $obj->gettoken;
is($tag[0], '<!ELEMENT br EMPTY>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/element2.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT p (#PCDATA|emph)* >');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/element3.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT %name.para; %content.para; >');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/element4.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT container ANY>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/element5.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT spec (front, body, back?)>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/element6.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT div1 (head, (p | list | note)*, div2)>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/element7.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT dictionary-body (%div.mix; | %dict.mix;)*>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/element8.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT p (#PCDATA|a|ul|b|i|em)*>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/element9.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT p (#PCDATA | %font; | %phrase; | %special; | %form;)* >');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/element10.tags');
@tag = $obj->gettoken;
is($tag[0], '<!ELEMENT b (#PCDATA)>');
is($tag[1], '!element');
is($tag[2], 1);
is($tag[3], 1);
