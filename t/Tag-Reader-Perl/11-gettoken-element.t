# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 10;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element1.sgml')->s);
my @tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		'<!ELEMENT br EMPTY>',
		'!element',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element2.sgml')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		'<!ELEMENT p (#PCDATA|emph)* >',
		'!element',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element3.sgml')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		'<!ELEMENT %name.para; %content.para; >',
		'!element',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element4.sgml')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		'<!ELEMENT container ANY>',
		'!element',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element5.sgml')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		'<!ELEMENT spec (front, body, back?)>',
		'!element',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element6.sgml')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		'<!ELEMENT div1 (head, (p | list | note)*, div2)>',
		'!element',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element7.sgml')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		'<!ELEMENT dictionary-body (%div.mix; | %dict.mix;)*>',
		'!element',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element8.sgml')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		'<!ELEMENT p (#PCDATA|a|ul|b|i|em)*>',
		'!element',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element9.sgml')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		'<!ELEMENT p (#PCDATA | %font; | %phrase; | %special; '.
			'| %form;)* >',
		'!element',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('element10.sgml')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		'<!ELEMENT b (#PCDATA)>',
		'!element',
		1,
		1,
	],
);
