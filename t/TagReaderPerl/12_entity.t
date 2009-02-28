# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Entity test.\n" if $debug;
my $obj = $class->new;
$obj->set_file($test_dir.'/data/entity1.tags');
my @tag = $obj->gettoken;
ok($tag[0], "<!ENTITY d \"&#xD;\">");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity2.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY a \"&#xA;\">");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity3.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY da \"&#xD;&#xA;\">");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity4.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY % ISOLat2\n         SYSTEM ".
	"\"http://www.xml.com/iso/isolatin2-xml.entities\" >");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity5.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY Pub-Status \"This is a pre-release of the specification.\">");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity6.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY open-hatch\n         SYSTEM ".
	"\"http://www.textuality.com/boilerplate/OpenHatch.xml\">");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity7.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY open-hatch\n         PUBLIC \"-//Textuality//TEXT ".
	"Standard open-hatch boilerplate//EN\"\n".
	"         \"http://www.textuality.com/boilerplate/OpenHatch.xml\">");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity8.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY hatch-pic\n         SYSTEM \"../grafix/OpenHatch.gif\"".
	"\n         NDATA gif >");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity9.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY % YN '\"Yes\"' >");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY WhatHeSaid \"He said \%YN;\" >");
ok($tag[1], '!entity');
ok($tag[2], 2);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity10.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY % pub    \"&#xc9;ditions Gallimard\" >");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY   rights \"All rights reserved\" >");
ok($tag[1], '!entity');
ok($tag[2], 2);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY   book   \"La Peste: Albert Camus,\n".
	"&#xA9; 1947 \%pub;. &rights;\" >");
ok($tag[1], '!entity');
ok($tag[2], 3);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity11.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY lt     \"&#38;#60;\">");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY gt     \"&#62;\">");
ok($tag[1], '!entity');
ok($tag[2], 2);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY amp    \"&#38;#38;\">");
ok($tag[1], '!entity');
ok($tag[2], 3);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY apos   \"&#39;\">");
ok($tag[1], '!entity');
ok($tag[2], 4);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY quot   \"&#34;\">");
ok($tag[1], '!entity');
ok($tag[2], 5);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/entity12.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY % zz '&#60;!ENTITY tricky \"error-prone\" >' >");
ok($tag[1], '!entity');
ok($tag[2], 1);
ok($tag[3], 1);
