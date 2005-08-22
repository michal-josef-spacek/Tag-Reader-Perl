# $Id: 03_start_tag.t,v 1.4 2005-08-22 16:25:56 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Start of tag.\n" if $debug;
my $obj = $class->new;
$obj->set_file($test_dir.'/data/start_tag1.tags');
my @tag = $obj->gettoken;
ok($tag[0], "<tag>");
ok($tag[1], "tag");
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/start_tag2.tags');
@tag = $obj->gettoken;
ok($tag[0], "<tag:color>");
ok($tag[1], "tag:color");
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/start_tag3.tags');
@tag = $obj->gettoken;
ok($tag[0], "<tag attr=\"param\">");
ok($tag[1], "tag");
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/start_tag4.tags');
@tag = $obj->gettoken;
ok($tag[0], "<tag attr=\"param\" />");
ok($tag[1], "tag");
ok($tag[2], 1);
ok($tag[3], 1);

