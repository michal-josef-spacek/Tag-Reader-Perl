# Modules.
use Tag::Reader::Perl;
use Test::More 'tests' => 8;

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/Tag::Reader::Perl";

print "Testing: Notation test.\n";
my $obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/notation1.tags');
my @tag = $obj->gettoken;
is($tag[0], "<!NOTATION USDATE SYSTEM \"http://www.schema.net/usdate.not\">");
is($tag[1], '!notation');
is($tag[2], 1);
is($tag[3], 1);

$obj = Tag::Reader::Perl->new;
$obj->set_file($test_dir.'/data/notation2.tags');
@tag = $obj->gettoken;
is($tag[0], "<!NOTATION GIF\n           PUBLIC \"-//IETF/NOSGML Media ".
	"Type image/gif//EN\"\n           \"http://www.bug.com/image/gif\">");
is($tag[1], '!notation');
is($tag[2], 1);
is($tag[3], 1);
