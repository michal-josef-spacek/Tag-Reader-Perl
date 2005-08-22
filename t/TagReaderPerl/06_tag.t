# $Id: 06_tag.t,v 1.4 2005-08-22 16:25:56 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Tags example.\n" if $debug;
my $obj = $class->new;
$obj->set_file($test_dir.'/data/tag1.tags');
my @tag = $obj->gettoken;
ok($tag[0], "<text>");
ok($tag[1], "text");
ok($tag[2], 1);
ok($tag[3], 1);
@tag = $obj->gettoken;
ok($tag[0], 'text');
ok($tag[1], 'data');
ok($tag[2], 1);
ok($tag[3], 7);
@tag = $obj->gettoken;
ok($tag[0], '</text>');
ok($tag[1], '/text');
ok($tag[2], 1);
ok($tag[3], 11);
@tag = $obj->gettoken;
ok($tag[0], "\n");
ok($tag[1], 'data');
ok($tag[2], 1);
ok($tag[3], 18);
