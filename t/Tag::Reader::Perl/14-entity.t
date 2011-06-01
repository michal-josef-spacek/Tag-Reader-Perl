# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 76;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity1.tags')->s);
my @tag = $obj->gettoken;
is($tag[0], "<!ENTITY d \"&#xD;\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity2.tags')->s);
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY a \"&#xA;\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity3.tags')->s);
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY da \"&#xD;&#xA;\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity4.tags')->s);
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY % ISOLat2\n         SYSTEM ".
	"\"http://www.xml.com/iso/isolatin2-xml.entities\" >");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity5.tags')->s);
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY Pub-Status \"This is a pre-release of the specification.\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity6.tags')->s);
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY open-hatch\n         SYSTEM ".
	"\"http://www.textuality.com/boilerplate/OpenHatch.xml\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity7.tags')->s);
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY open-hatch\n         PUBLIC \"-//Textuality//TEXT ".
	"Standard open-hatch boilerplate//EN\"\n".
	"         \"http://www.textuality.com/boilerplate/OpenHatch.xml\">");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity8.tags')->s);
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY hatch-pic\n         SYSTEM \"../grafix/OpenHatch.gif\"".
	"\n         NDATA gif >");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity9.tags')->s);
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

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity10.tags')->s);
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

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity11.tags')->s);
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

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity12.tags')->s);
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY % zz '&#60;!ENTITY tricky \"error-prone\" >' >");
is($tag[1], '!entity');
is($tag[2], 1);
is($tag[3], 1);
