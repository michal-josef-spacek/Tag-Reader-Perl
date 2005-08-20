# $Id: 05_comment.t,v 1.1 2005-08-20 06:02:48 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Comment tag.\n" if $debug;
my $obj = $class->new($test_dir.'/data/comment1.tags');
my @tag = $obj->gettoken(1);
ok($tag[0], "<!-- comment -->");
ok($tag[1], "!--");
ok($tag[2], 1);
ok($tag[3], 2);

$obj = $class->new($test_dir.'/data/comment2.tags');
@tag = $obj->gettoken(1);
ok($tag[0], "<!-- <tag> text </tag> -->");
ok($tag[1], "!--");
ok($tag[2], 1);
ok($tag[3], 2);

