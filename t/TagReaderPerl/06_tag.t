# $Id: 06_tag.t,v 1.1 2005-08-20 06:02:48 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Tags example.\n" if $debug;
my $obj = $class->new($test_dir.'/data/tag1.tags');
my @tag = $obj->gettoken(1);
ok($tag[0], "<text>");
ok($tag[1], "text");
ok($tag[2], 1);
ok($tag[3], 2);
@tag = $obj->gettoken(1);
ok($tag[0], 'text');
ok($tag[1], '');
ok($tag[2], 1);
ok($tag[3], 8);
@tag = $obj->gettoken(1);
ok($tag[0], '</text>');
ok($tag[1], '/text');
ok($tag[2], 1);
ok($tag[3], 12);
@tag = $obj->gettoken(1);
ok($tag[0], "\n");
ok($tag[1], '');
ok($tag[2], 1);
ok($tag[3], 12);
