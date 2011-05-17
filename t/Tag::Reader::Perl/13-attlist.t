# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 24;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/attlist1.tags');
my @tag = $obj->gettoken;
is($tag[0], "<!ATTLIST termdef\n          id      ID      #REQUIRED\n".
	"          name    CDATA   #IMPLIED>");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/attlist2.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST list\n          type    (bullets|ordered|glossary)  ".
	"\"ordered\">");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/attlist3.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST form\n          method  CDATA   #FIXED \"POST\">");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/attlist4.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST poem xml:space (default|preserve) 'preserve'>");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/attlist5.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST pre xml:space (preserve) #FIXED 'preserve'>");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/attlist6.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST DATE FORMAT NOTATION (USDATE|AUSDATE|ISODATE) \"ISODATE\">");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);
