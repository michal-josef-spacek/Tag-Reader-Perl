# Modules.
use File::Object;
use Tag::Reader::Perl;
use Test::More 'tests' => 248;

# Directories.
my $data_dir = File::Object->new->up->dir('data')->serialize;

# Test.
my $obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/doc1.tags');
my @tag = $obj->gettoken;
is($tag[0], "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>");
is($tag[1], "?xml");
is($tag[2], 1);
is($tag[3], 1);
@tag = $obj->gettoken;
is($tag[0], "\n");
is($tag[1], 'data');
is($tag[2], 1);
is($tag[3], 56);
@tag = $obj->gettoken;
is($tag[0], "<!DOCTYPE greeting [\n\t<!ELEMENT greeting (#PCDATA)>\n]>");
is($tag[1], "!doctype");
is($tag[2], 2);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<greeting>");
is($tag[1], "greeting");
is($tag[2], 5);
is($tag[3], 1);
@tag = $obj->gettoken;
is($tag[0], 'Hello, world!');
is($tag[1], 'data');
is($tag[2], 5);
is($tag[3], 11);
@tag = $obj->gettoken;
is($tag[0], "</greeting>");
is($tag[1], "/greeting");
is($tag[2], 5);
is($tag[3], 24);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/doc2.tags');
@tag = $obj->gettoken;
is($tag[0], "<?xml version=\"1.0\" standalone=\"yes\"?>");
is($tag[1], "?xml");
is($tag[2], 1);
is($tag[3], 1);
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
is($tag[0], $right_ret);
is($tag[1], "!doctype");
is($tag[2], 2);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<image height=\"32\" width=\"32\"/>");
is($tag[1], "image");
is($tag[2], 8);
is($tag[3], 1);
$right_ret =~ s/^<!DOCTYPE image \[//;
$right_ret =~ s/\]>$//;
$obj->set_text($right_ret, 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ELEMENT image EMPTY>");
is($tag[1], "!element");
is($tag[2], 2);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
$right_ret = <<"END";
<!ATTLIST image
    height CDATA #REQUIRED
    width CDATA #REQUIRED>
END
chomp $right_ret;
is($tag[0], $right_ret);
is($tag[1], "!attlist");
is($tag[2], 3);
is($tag[3], 3);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/doc3.tags');
@tag = $obj->gettoken;
is($tag[0], "<?xml version=\"1.0\" standalone=\"yes\"?>");
is($tag[1], "?xml");
is($tag[2], 1);
is($tag[3], 1);
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
is($tag[0], $right_ret);
is($tag[1], "!doctype");
is($tag[2], 2);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<family>");
is($tag[1], "family");
is($tag[2], 7);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<parent>");
is($tag[1], "parent");
is($tag[2], 8);
is($tag[3], 3);
@tag = $obj->gettoken;
is($tag[0], "Judy");
is($tag[1], "data");
is($tag[2], 8);
is($tag[3], 11);
@tag = $obj->gettoken;
is($tag[0], "</parent>");
is($tag[1], "/parent");
is($tag[2], 8);
is($tag[3], 15);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<parent>");
is($tag[1], "parent");
is($tag[2], 9);
is($tag[3], 3);
@tag = $obj->gettoken;
is($tag[0], "Layard");
is($tag[1], "data");
is($tag[2], 9);
is($tag[3], 11);
@tag = $obj->gettoken;
is($tag[0], "</parent>");
is($tag[1], "/parent");
is($tag[2], 9);
is($tag[3], 17);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<child>");
is($tag[1], "child");
is($tag[2], 10);
is($tag[3], 3);
@tag = $obj->gettoken;
is($tag[0], "Jennifer");
is($tag[1], "data");
is($tag[2], 10);
is($tag[3], 10);
@tag = $obj->gettoken;
is($tag[0], "</child>");
is($tag[1], "/child");
is($tag[2], 10);
is($tag[3], 18);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<child>");
is($tag[1], "child");
is($tag[2], 11);
is($tag[3], 3);
@tag = $obj->gettoken;
is($tag[0], "Brendan");
is($tag[1], "data");
is($tag[2], 11);
is($tag[3], 10);
@tag = $obj->gettoken;
is($tag[0], "</child>");
is($tag[1], "/child");
is($tag[2], 11);
is($tag[3], 17);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "</family>");
is($tag[1], "/family");
is($tag[2], 12);
is($tag[3], 1);
$right_ret =~ s/^<!DOCTYPE family \[//;
$right_ret =~ s/\]>$//;
$obj->set_text($right_ret, 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ELEMENT family (parent|child)*>");
is($tag[1], "!element");
is($tag[2], 2);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ELEMENT parent (#PCDATA)>");
is($tag[1], "!element");
is($tag[2], 3);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ELEMENT child (#PCDATA)>");
is($tag[1], "!element");
is($tag[2], 4);
is($tag[3], 3);

# Test.
$obj = Tag::Reader::Perl->new;
$obj->set_file($data_dir.'/doc4.tags');
@tag = $obj->gettoken;
is($tag[0], "<?xml version=\"1.0\" standalone=\"yes\"?>");
is($tag[1], "?xml");
is($tag[2], 1);
is($tag[3], 1);
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
is($tag[0], $right_ret);
is($tag[1], "!doctype");
is($tag[2], 2);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<family>");
is($tag[1], "family");
is($tag[2], 16);
is($tag[3], 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<title>");
is($tag[1], "title");
is($tag[2], 17);
is($tag[3], 3);
@tag = $obj->gettoken;
is($tag[0], "My Family");
is($tag[1], "data");
is($tag[2], 17);
is($tag[3], 10);
@tag = $obj->gettoken;
is($tag[0], "</title>");
is($tag[1], "/title");
is($tag[2], 17);
is($tag[3], 19);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<parent role=\"mother\">");
is($tag[1], "parent");
is($tag[2], 18);
is($tag[3], 3);
@tag = $obj->gettoken;
is($tag[0], "Judy");
is($tag[1], "data");
is($tag[2], 18);
is($tag[3], 25);
@tag = $obj->gettoken;
is($tag[0], "</parent>");
is($tag[1], "/parent");
is($tag[2], 18);
is($tag[3], 29);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<parent role=\"father\">");
is($tag[1], "parent");
is($tag[2], 19);
is($tag[3], 3);
@tag = $obj->gettoken;
is($tag[0], "Layard");
is($tag[1], "data");
is($tag[2], 19);
is($tag[3], 25);
@tag = $obj->gettoken;
is($tag[0], "</parent>");
is($tag[1], "/parent");
is($tag[2], 19);
is($tag[3], 31);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<child role=\"daughter\">");
is($tag[1], "child");
is($tag[2], 20);
is($tag[3], 3);
@tag = $obj->gettoken;
is($tag[0], "Jennifer");
is($tag[1], "data");
is($tag[2], 20);
is($tag[3], 26);
@tag = $obj->gettoken;
is($tag[0], "</child>");
is($tag[1], "/child");
is($tag[2], 20);
is($tag[3], 34);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<image source=\"JENN\" />");
is($tag[1], "image");
is($tag[2], 21);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<child role=\"son\">");
is($tag[1], "child");
is($tag[2], 22);
is($tag[3], 3);
@tag = $obj->gettoken;
is($tag[0], "Brendan");
is($tag[1], "data");
is($tag[2], 22);
is($tag[3], 21);
@tag = $obj->gettoken;
is($tag[0], "</child>");
is($tag[1], "/child");
is($tag[2], 22);
is($tag[3], 28);
@tag = $obj->gettoken;
is($tag[0], "\n  &footer;\n");
is($tag[1], "data");
is($tag[2], 22);
is($tag[3], 36);
@tag = $obj->gettoken;
is($tag[0], "</family>");
is($tag[1], "/family");
is($tag[2], 24);
is($tag[3], 1);
$right_ret =~ s/^<!DOCTYPE family \[//;
$right_ret =~ s/\]>$//;
$obj->set_text($right_ret, 1);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ELEMENT family (#PCDATA|title|parent|child|image)*>");
is($tag[1], "!element");
is($tag[2], 2);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ELEMENT title (#PCDATA)>");
is($tag[1], "!element");
is($tag[2], 3);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ELEMENT parent (#PCDATA)>");
is($tag[1], "!element");
is($tag[2], 4);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST parent role (mother | father) #REQUIRED>");
is($tag[1], "!attlist");
is($tag[2], 5);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ELEMENT child (#PCDATA)>");
is($tag[1], "!element");
is($tag[2], 6);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST child role (daughter | son) #REQUIRED>");
is($tag[1], "!attlist");
is($tag[2], 7);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!NOTATION gif SYSTEM \"image/gif\">");
is($tag[1], "!notation");
is($tag[2], 8);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY JENN SYSTEM ".
	"\"http://images.about.com/sites/guidepics/html.gif\"\n".
	"    NDATA gif>");
is($tag[1], "!entity");
is($tag[2], 9);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ELEMENT image EMPTY>");
is($tag[1], "!element");
is($tag[2], 11);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ATTLIST image source ENTITY #REQUIRED>");
is($tag[1], "!attlist");
is($tag[2], 12);
is($tag[3], 3);
@tag = $obj->gettoken;
@tag = $obj->gettoken;
is($tag[0], "<!ENTITY footer \"Brought to you by Jennifer Kyrnin\">");
is($tag[1], "!entity");
is($tag[2], 13);
is($tag[3], 3);
