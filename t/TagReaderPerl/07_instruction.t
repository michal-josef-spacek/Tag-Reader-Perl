# $Id: 07_instruction.t,v 1.2 2005-08-22 00:30:20 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Instruction tag.\n" if $debug;
my $obj = $class->new($test_dir.'/data/instruction1.tags');
my @tag = $obj->gettoken(1);
ok($tag[0], "<?xml?>");
ok($tag[1], "?xml");
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new($test_dir.'/data/instruction2.tags');
@tag = $obj->gettoken(1);
ok($tag[0], "<?xml version=\"1.0\"?>");
ok($tag[1], "?xml");
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new($test_dir.'/data/instruction3.tags');
@tag = $obj->gettoken(1);
ok($tag[0], "<?application This is normal sentence.\nAnd second sentence.?>");
ok($tag[1], "?application");
ok($tag[2], 1);
ok($tag[3], 1);
