# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Element test.\n" if $debug;
my $obj = $class->new;
$obj->set_file($test_dir.'/data/element1.tags');
my @tag = $obj->gettoken;
ok($tag[0], '<!ELEMENT br EMPTY>');
ok($tag[1], '!element');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/element2.tags');
@tag = $obj->gettoken;
ok($tag[0], '<!ELEMENT p (#PCDATA|emph)* >');
ok($tag[1], '!element');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/element3.tags');
@tag = $obj->gettoken;
ok($tag[0], '<!ELEMENT %name.para; %content.para; >');
ok($tag[1], '!element');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/element4.tags');
@tag = $obj->gettoken;
ok($tag[0], '<!ELEMENT container ANY>');
ok($tag[1], '!element');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/element5.tags');
@tag = $obj->gettoken;
ok($tag[0], '<!ELEMENT spec (front, body, back?)>');
ok($tag[1], '!element');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/element6.tags');
@tag = $obj->gettoken;
ok($tag[0], '<!ELEMENT div1 (head, (p | list | note)*, div2)>');
ok($tag[1], '!element');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/element7.tags');
@tag = $obj->gettoken;
ok($tag[0], '<!ELEMENT dictionary-body (%div.mix; | %dict.mix;)*>');
ok($tag[1], '!element');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/element8.tags');
@tag = $obj->gettoken;
ok($tag[0], '<!ELEMENT p (#PCDATA|a|ul|b|i|em)*>');
ok($tag[1], '!element');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/element9.tags');
@tag = $obj->gettoken;
ok($tag[0], '<!ELEMENT p (#PCDATA | %font; | %phrase; | %special; | %form;)* >');
ok($tag[1], '!element');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/element10.tags');
@tag = $obj->gettoken;
ok($tag[0], '<!ELEMENT b (#PCDATA)>');
ok($tag[1], '!element');
ok($tag[2], 1);
ok($tag[3], 1);
