# Test directory.
my $test_dir = "$ENV{'PWD'}/t/Tag::Reader::Perl";

# Modules.
use Tag::Reader::Perl;
use Test::More 'tests' => 76;

print "Testing: Entity test.\n";
my $obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity1.tags');
my @tag = $obj->gettoken;
is($tag[0], "<!ENTITY d \"&#xD;\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity2.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY a \"&#xA;\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity3.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY da \"&#xD;&#xA;\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity4.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY % ISOLat2\n         SYSTEM ".
	"\"http://www.xml.com/iso/isolatin2-xml.entities\" >");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity5.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY Pub-Status \"This is a pre-release of the specification.\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity6.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY open-hatch\n         SYSTEM ".
	"\"http://www.textuality.com/boilerplate/OpenHatch.xml\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity7.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY open-hatch\n         PUBLIC \"-//Textuality//TEXT ".
	"Standard open-hatch boilerplate//EN\"\n".
	"         \"http://www.textuality.com/boilerplate/OpenHatch.xml\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity8.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY hatch-pic\n         SYSTEM \"../grafix/OpenHatch.gif\"".
	"\n         NDATA gif >");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity9.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY % YN '\"Yes\"' >");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY WhatHeSaid \"He said \%YN;\" >");
is($tag[1], '!entity');
is($tag[2], 2);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity10.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY % pub    \"&#xc9;ditions Gallimard\" >");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY   rights \"All rights reserved\" >");
is($tag[1], '!entity');
is($tag[2], 2);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY   book   \"La Peste: Albert Camus,\n".
	"&#xA9; 1947 \%pub;. &rights;\" >");
is($tag[1], '!entity');
is($tag[2], 3);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity11.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY lt     \"&#38;#60;\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY gt     \"&#62;\">");
is($tag[1], '!entity');
is($tag[2], 2);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY amp    \"&#38;#38;\">");
is($tag[1], '!entity');
is($tag[2], 3);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY apos   \"&#39;\">");
is($tag[1], '!entity');
is($tag[2], 4);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY quot   \"&#34;\">");
is($tag[1], '!entity');
is($tag[2], 5);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/entity12.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY % zz '&#60;!ENTITY tricky \"error-prone\" >' >");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);
