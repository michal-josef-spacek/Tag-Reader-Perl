# $Id: 08_doc.t,v 1.7 2005-08-25 15:10:42 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Full document test.\n" if $debug;
my $obj = $class->new;
$obj->set_file($test_dir.'/data/doc1.tags');
my @tag = $obj->gettoken;
ok($tag[0], "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>");
ok($tag[1], "?xml");
ok($tag[2], 1);
ok($tag[3], 1);
@tag = $obj->gettoken;
ok($tag[0], "\n");
ok($tag[1], 'data');
ok($tag[2], 1);
ok($tag[3], 56);
@tag = $obj->gettoken;
ok($tag[0], "<!DOCTYPE greeting [\n\t<!ELEMENT greeting (#PCDATA)>\n]>");
ok($tag[1], "!doctype");
ok($tag[2], 2);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<greeting>");
ok($tag[1], "greeting");
ok($tag[2], 5);
ok($tag[3], 1);
@tag = $obj->gettoken;
ok($tag[0], 'Hello, world!');
ok($tag[1], 'data');
ok($tag[2], 5);
ok($tag[3], 11);
@tag = $obj->gettoken;
ok($tag[0], "</greeting>");
ok($tag[1], "/greeting");
ok($tag[2], 5);
ok($tag[3], 24);

$obj = $class->new;
$obj->set_file($test_dir.'/data/doc2.tags');
@tag = $obj->gettoken;
ok($tag[0], "<?xml version=\"1.0\" standalone=\"yes\"?>");
ok($tag[1], "?xml");
ok($tag[2], 1);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
my $right_ret = <<"END";
<!DOCTYPE image [
  <!ELEMENT image EMPTY>
  <!ATTLIST image
    height CDATA #REQUIRED
    width CDATA #REQUIRED>
]>
END
chomp $right_ret;
ok($tag[0], $right_ret);
ok($tag[1], "!doctype");
ok($tag[2], 2);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<image height=\"32\" width=\"32\"/>");
ok($tag[1], "image");
ok($tag[2], 8);
ok($tag[3], 1);
$right_ret =~ s/^<!DOCTYPE image \[//;
$right_ret =~ s/\]>$//;
$obj->set_text($right_ret, 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ELEMENT image EMPTY>");
ok($tag[1], "!element");
ok($tag[2], 2);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
$right_ret = <<"END";
<!ATTLIST image
    height CDATA #REQUIRED
    width CDATA #REQUIRED>
END
chomp $right_ret;
ok($tag[0], $right_ret);
ok($tag[1], "!attlist");
ok($tag[2], 3);
ok($tag[3], 3);

$obj = $class->new;
$obj->set_file($test_dir.'/data/doc3.tags');
@tag = $obj->gettoken;
ok($tag[0], "<?xml version=\"1.0\" standalone=\"yes\"?>");
ok($tag[1], "?xml");
ok($tag[2], 1);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
$right_ret = <<"END";
<!DOCTYPE family [
  <!ELEMENT family (parent|child)*>
  <!ELEMENT parent (#PCDATA)>
  <!ELEMENT child (#PCDATA)>
]>
END
chomp $right_ret;
ok($tag[0], $right_ret);
ok($tag[1], "!doctype");
ok($tag[2], 2);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<family>");
ok($tag[1], "family");
ok($tag[2], 7);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<parent>");
ok($tag[1], "parent");
ok($tag[2], 8);
ok($tag[3], 3);
@tag = $obj->gettoken;
ok($tag[0], "Judy");
ok($tag[1], "data");
ok($tag[2], 8);
ok($tag[3], 11);
@tag = $obj->gettoken;
ok($tag[0], "</parent>");
ok($tag[1], "/parent");
ok($tag[2], 8);
ok($tag[3], 15);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<parent>");
ok($tag[1], "parent");
ok($tag[2], 9);
ok($tag[3], 3);
@tag = $obj->gettoken;
ok($tag[0], "Layard");
ok($tag[1], "data");
ok($tag[2], 9);
ok($tag[3], 11);
@tag = $obj->gettoken;
ok($tag[0], "</parent>");
ok($tag[1], "/parent");
ok($tag[2], 9);
ok($tag[3], 17);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<child>");
ok($tag[1], "child");
ok($tag[2], 10);
ok($tag[3], 3);
@tag = $obj->gettoken;
ok($tag[0], "Jennifer");
ok($tag[1], "data");
ok($tag[2], 10);
ok($tag[3], 10);
@tag = $obj->gettoken;
ok($tag[0], "</child>");
ok($tag[1], "/child");
ok($tag[2], 10);
ok($tag[3], 18);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<child>");
ok($tag[1], "child");
ok($tag[2], 11);
ok($tag[3], 3);
@tag = $obj->gettoken;
ok($tag[0], "Brendan");
ok($tag[1], "data");
ok($tag[2], 11);
ok($tag[3], 10);
@tag = $obj->gettoken;
ok($tag[0], "</child>");
ok($tag[1], "/child");
ok($tag[2], 11);
ok($tag[3], 17);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "</family>");
ok($tag[1], "/family");
ok($tag[2], 12);
ok($tag[3], 1);
$right_ret =~ s/^<!DOCTYPE family \[//;
$right_ret =~ s/\]>$//;
$obj->set_text($right_ret, 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ELEMENT family (parent|child)*>");
ok($tag[1], "!element");
ok($tag[2], 2);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ELEMENT parent (#PCDATA)>");
ok($tag[1], "!element");
ok($tag[2], 3);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ELEMENT child (#PCDATA)>");
ok($tag[1], "!element");
ok($tag[2], 4);
ok($tag[3], 3);

$obj = $class->new;
$obj->set_file($test_dir.'/data/doc4.tags');
@tag = $obj->gettoken;
ok($tag[0], "<?xml version=\"1.0\" standalone=\"yes\"?>");
ok($tag[1], "?xml");
ok($tag[2], 1);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
$right_ret = <<"END";
<!DOCTYPE family [
  <!ELEMENT family (#PCDATA|title|parent|child|image)*>
  <!ELEMENT title (#PCDATA)>
  <!ELEMENT parent (#PCDATA)>
  <!ATTLIST parent role (mother | father) #REQUIRED>
  <!ELEMENT child (#PCDATA)>
  <!ATTLIST child role (daughter | son) #REQUIRED>
  <!NOTATION gif SYSTEM "image/gif">
  <!ENTITY JENN SYSTEM "http://images.about.com/sites/guidepics/html.gif"
    NDATA gif>
  <!ELEMENT image EMPTY>
  <!ATTLIST image source ENTITY #REQUIRED>
  <!ENTITY footer "Brought to you by Jennifer Kyrnin">
]>
END
chomp $right_ret;
ok($tag[0], $right_ret);
ok($tag[1], "!doctype");
ok($tag[2], 2);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<family>");
ok($tag[1], "family");
ok($tag[2], 16);
ok($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<title>");
ok($tag[1], "title");
ok($tag[2], 17);
ok($tag[3], 3);
@tag = $obj->gettoken;
ok($tag[0], "My Family");
ok($tag[1], "data");
ok($tag[2], 17);
ok($tag[3], 10);
@tag = $obj->gettoken;
ok($tag[0], "</title>");
ok($tag[1], "/title");
ok($tag[2], 17);
ok($tag[3], 19);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<parent role=\"mother\">");
ok($tag[1], "parent");
ok($tag[2], 18);
ok($tag[3], 3);
@tag = $obj->gettoken;
ok($tag[0], "Judy");
ok($tag[1], "data");
ok($tag[2], 18);
ok($tag[3], 25);
@tag = $obj->gettoken;
ok($tag[0], "</parent>");
ok($tag[1], "/parent");
ok($tag[2], 18);
ok($tag[3], 29);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<parent role=\"father\">");
ok($tag[1], "parent");
ok($tag[2], 19);
ok($tag[3], 3);
@tag = $obj->gettoken;
ok($tag[0], "Layard");
ok($tag[1], "data");
ok($tag[2], 19);
ok($tag[3], 25);
@tag = $obj->gettoken;
ok($tag[0], "</parent>");
ok($tag[1], "/parent");
ok($tag[2], 19);
ok($tag[3], 31);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<child role=\"daughter\">");
ok($tag[1], "child");
ok($tag[2], 20);
ok($tag[3], 3);
@tag = $obj->gettoken;
ok($tag[0], "Jennifer");
ok($tag[1], "data");
ok($tag[2], 20);
ok($tag[3], 26);
@tag = $obj->gettoken;
ok($tag[0], "</child>");
ok($tag[1], "/child");
ok($tag[2], 20);
ok($tag[3], 34);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<image source=\"JENN\" />");
ok($tag[1], "image");
ok($tag[2], 21);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<child role=\"son\">");
ok($tag[1], "child");
ok($tag[2], 22);
ok($tag[3], 3);
@tag = $obj->gettoken;
ok($tag[0], "Brendan");
ok($tag[1], "data");
ok($tag[2], 22);
ok($tag[3], 21);
@tag = $obj->gettoken;
ok($tag[0], "</child>");
ok($tag[1], "/child");
ok($tag[2], 22);
ok($tag[3], 28);
@tag = $obj->gettoken;
ok($tag[0], "\n  &footer;\n");
ok($tag[1], "data");
ok($tag[2], 22);
ok($tag[3], 36);
@tag = $obj->gettoken;
ok($tag[0], "</family>");
ok($tag[1], "/family");
ok($tag[2], 24);
ok($tag[3], 1);
$right_ret =~ s/^<!DOCTYPE family \[//;
$right_ret =~ s/\]>$//;
$obj->set_text($right_ret, 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ELEMENT family (#PCDATA|title|parent|child|image)*>");
ok($tag[1], "!element");
ok($tag[2], 2);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ELEMENT title (#PCDATA)>");
ok($tag[1], "!element");
ok($tag[2], 3);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ELEMENT parent (#PCDATA)>");
ok($tag[1], "!element");
ok($tag[2], 4);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ATTLIST parent role (mother | father) #REQUIRED>");
ok($tag[1], "!attlist");
ok($tag[2], 5);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ELEMENT child (#PCDATA)>");
ok($tag[1], "!element");
ok($tag[2], 6);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ATTLIST child role (daughter | son) #REQUIRED>");
ok($tag[1], "!attlist");
ok($tag[2], 7);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!NOTATION gif SYSTEM \"image/gif\">");
ok($tag[1], "!notation");
ok($tag[2], 8);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY JENN SYSTEM ".
	"\"http://images.about.com/sites/guidepics/html.gif\"\n".
	"    NDATA gif>");
ok($tag[1], "!entity");
ok($tag[2], 9);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ELEMENT image EMPTY>");
ok($tag[1], "!element");
ok($tag[2], 11);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ATTLIST image source ENTITY #REQUIRED>");
ok($tag[1], "!attlist");
ok($tag[2], 12);
ok($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
ok($tag[0], "<!ENTITY footer \"Brought to you by Jennifer Kyrnin\">");
ok($tag[1], "!entity");
ok($tag[2], 13);
ok($tag[3], 3);
