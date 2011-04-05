# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 8;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Debug message.
print "Testing: Notation test.\n";

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/notation1.tags');
my @tag = $obj->gettoken;
is($tag[0], "<!NOTATION USDATE SYSTEM \"http://www.schema.net/usdate.not\">");
is($tag[1], '!notation');
is($tag[2], 1);
is($tag[3], 1);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/notation2.tags');
@tag = $obj->gettoken;
is($tag[0], "<!NOTATION GIF\n           PUBLIC \"-//IETF/NOSGML Media ".
	"Type image/gif//EN\"\n           \"http://www.bug.com/image/gif\">");
is($tag[1], '!notation');
is($tag[2], 1);
is($tag[3], 1);
