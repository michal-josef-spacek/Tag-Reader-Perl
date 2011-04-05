# Modules.
use Tag::Reader::Perl;
use Test::More 'tests' => 24;

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/Tag::Reader::Perl";

print "Testing: Attlist test.\n";
my $obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/attlist1.tags');
my @tag = $obj->gettoken;
is($tag[0], "<!ATTLIST termdef\n          id      ID      #REQUIRED\n".
	"          name    CDATA   #IMPLIED>");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/attlist2.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST list\n          type    (bullets|ordered|glossary)  ".
	"\"ordered\">");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/attlist3.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST form\n          method  CDATA   #FIXED \"POST\">");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/attlist4.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST poem xml:space (default|preserve) 'preserve'>");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/attlist5.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST pre xml:space (preserve) #FIXED 'preserve'>");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/attlist6.tags');
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST DATE FORMAT NOTATION (USDATE|AUSDATE|ISODATE) \"ISODATE\">");
is($tag[1], '!attlist');
is($tag[2], 1);
is($tag[3], 1);
