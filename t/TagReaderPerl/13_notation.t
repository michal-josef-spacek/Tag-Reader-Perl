# $Id: 13_notation.t,v 1.1 2005-08-24 15:30:58 skim Exp $

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

