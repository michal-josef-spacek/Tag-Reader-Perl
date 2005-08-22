# $Id: 08_doc.t,v 1.2 2005-08-22 00:30:20 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Full document test.\n" if $debug;
my $obj = $class->new($test_dir.'/data/doc1.tags');
my @tag = $obj->gettoken(1);
ok($tag[0], "<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
ok($tag[1], "?xml");
ok($tag[2], 1);
ok($tag[3], 1);
@tag = $obj->gettoken(1);
ok($tag[0], "\n");
ok($tag[1], 'data');
ok($tag[2], 1);
ok($tag[3], 39);
@tag = $obj->gettoken(1);
ok($tag[0], "<!DOCTYPE greeting [\n\t<!ELEMENT greeting (#PCDATA)>\n]>");
ok($tag[1], "!doctype");
ok($tag[2], 2);
ok($tag[3], 1);
@tag = $obj->gettoken(1);
@tag = $obj->gettoken(1);
ok($tag[0], "<greeting>");
ok($tag[1], "greeting");
ok($tag[2], 5);
ok($tag[3], 1);
@tag = $obj->gettoken(1);
ok($tag[0], 'Hello, world!');
ok($tag[1], 'data');
ok($tag[2], 5);
ok($tag[3], 11);
@tag = $obj->gettoken(1);
ok($tag[0], "</greeting>");
ok($tag[1], "/greeting");
ok($tag[2], 5);
ok($tag[3], 24);
