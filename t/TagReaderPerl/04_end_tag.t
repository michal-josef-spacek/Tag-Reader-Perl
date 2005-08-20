# $Id: 04_end_tag.t,v 1.1 2005-08-20 06:02:48 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: End of tag.\n" if $debug;
my $obj = $class->new($test_dir.'/data/end_tag1.tags');
my @tag = $obj->gettoken(1);
ok($tag[0], "</tag>");
ok($tag[1], "/tag");
ok($tag[2], 1);
ok($tag[3], 2);

$obj = $class->new($test_dir.'/data/end_tag2.tags');
@tag = $obj->gettoken(1);
ok($tag[0], "</tag:color>");
ok($tag[1], "/tag:color");
ok($tag[2], 1);
ok($tag[3], 2);

