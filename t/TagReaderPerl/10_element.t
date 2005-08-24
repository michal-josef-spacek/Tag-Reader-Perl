# $Id: 10_element.t,v 1.1 2005-08-24 14:10:23 skim Exp $

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
