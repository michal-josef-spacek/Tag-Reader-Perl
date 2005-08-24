# $Id: 11_attlist.t,v 1.1 2005-08-24 14:30:44 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Element test.\n" if $debug;
my $obj = $class->new;
$obj->set_file($test_dir.'/data/attlist1.tags');
my @tag = $obj->gettoken;
ok($tag[0], "<!ATTLIST termdef\n          id      ID      #REQUIRED\n".
	"          name    CDATA   #IMPLIED>");
ok($tag[1], '!attlist');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/attlist2.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ATTLIST list\n          type    (bullets|ordered|glossary)  ".
	"\"ordered\">");
ok($tag[1], '!attlist');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/attlist3.tags');
@tag = $obj->gettoken;
ok($tag[0], "<!ATTLIST form\n          method  CDATA   #FIXED \"POST\">");
ok($tag[1], '!attlist');
ok($tag[2], 1);
ok($tag[3], 1);
