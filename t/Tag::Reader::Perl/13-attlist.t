# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 6;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('attlist1.tags')->s);
my @tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ATTLIST termdef\n          id      ID      #REQUIRED\n".
			"          name    CDATA   #IMPLIED>",
		'!attlist',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('attlist2.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ATTLIST list\n".
			"          type    (bullets|ordered|glossary)  ".
			"\"ordered\">",
		'!attlist',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('attlist3.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ATTLIST form\n          method  CDATA   #FIXED \"POST\">",
		'!attlist',
		1,	
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('attlist4.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ATTLIST poem xml:space (default|preserve) 'preserve'>",
		'!attlist',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('attlist5.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ATTLIST pre xml:space (preserve) #FIXED 'preserve'>",
		'!attlist',
		1,
		1,
	],
);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir->file('attlist6.tags')->s);
@tag = $obj->gettoken;
is_deeply(
	\@tag,
	[
		"<!ATTLIST DATE FORMAT NOTATION (USDATE|AUSDATE|ISODATE) ".
			"\"ISODATE\">",
		'!attlist',
		1,
		1,
	],
);
