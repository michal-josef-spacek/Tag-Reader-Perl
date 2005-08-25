# $Id: 13_notation.t,v 1.2 2005-08-25 10:22:41 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Notation test.\n" if $debug;
my $obj = $class->new;
$obj->set_file($test_dir.'/data/notation1.tags');
my @tag = $obj->gettoken;
ok($tag[0], "<!NOTATION USDATE SYSTEM \"http://www.schema.net/usdate.not\">");
ok($tag[1], '!notation');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/notation2.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!NOTATION GIF\n           PUBLIC \"-//IETF/NOSGML Media ".
	"Type image/gif//EN\"\n           \"http://www.bug.com/image/gif\">");
ok($tag[1], '!notation');
ok($tag[2], 1);
ok($tag[3], 1);

