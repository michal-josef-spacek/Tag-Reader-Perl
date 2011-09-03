# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 19;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity1.tags')->s);
my @tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY d \"&#xD;\">",
		'!entity',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity2.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY a \"&#xA;\">",
		'!entity',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity3.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY da \"&#xD;&#xA;\">",
		'!entity',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity4.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY % ISOLat2\n         SYSTEM ".
			"\"http://www.xml.com/iso/isolatin2-xml.entities\" >",
		'!entity',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity5.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY Pub-Status \"This is a pre-release of ".
			"the specification.\">",
		'!entity',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity6.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY open-hatch\n         SYSTEM ".
			"\"http://www.textuality.com/boilerplate/".
			"OpenHatch.xml\">",
		'!entity',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity7.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY open-hatch\n         PUBLIC \"-//Textuality//TEXT ".
			"Standard open-hatch boilerplate//EN\"\n".
			"         ".
			"\"http://www.textuality.com/boilerplate/".
			"OpenHatch.xml\">",
		'!entity',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity8.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY hatch-pic\n".
			"         SYSTEM \"../grafix/OpenHatch.gif\"".
			"\n         NDATA gif >",
		'!entity',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity9.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY % YN '\"Yes\"' >",
		'!entity',
		1,
		1,
	],
);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY WhatHeSaid \"He said \%YN;\" >",
		'!entity',
		2,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity10.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY % pub    \"&#xc9;ditions Gallimard\" >",
		'!entity',
		1,
		1,
	],
);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY   rights \"All rights reserved\" >",
		'!entity',
		2,
		1,
	],
);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY   book   \"La Peste: Albert Camus,\n".
			"&#xA9; 1947 \%pub;. &rights;\" >",
		'!entity',
		3,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity11.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY lt     \"&#38;#60;\">",
		'!entity',
		1,
		1,
	],
);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY gt     \"&#62;\">",
		'!entity',
		2,
		1,
	],
);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY amp    \"&#38;#38;\">",
		'!entity',
		3,
		1,
	],
);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY apos   \"&#39;\">",
		'!entity',
		4,
		1,
	],
);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY quot   \"&#34;\">",
		'!entity',
		5,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('entity12.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ENTITY % zz '&#60;!ENTITY tricky \"error-prone\" >' >",
		'!entity',
		1,
		1,
	],
);
