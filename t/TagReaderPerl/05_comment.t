# $Id: 05_comment.t,v 1.3 2005-08-22 16:17:54 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Comment tag.\n" if $debug;
my $obj = $class->new;
$obj->set_file($test_dir.'/data/comment1.tags');
my @tag = $obj->gettoken(1);
ok($tag[0], "<!-- comment -->");
ok($tag[1], "!--");
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/comment2.tags');
@tag = $obj->gettoken(1);
ok($tag[0], "<!-- <tag> text </tag> -->");
ok($tag[1], "!--");
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/comment3.tags');
@tag = $obj->gettoken(1);
ok($tag[0], "<!-- <<<< comment <> -->");
ok($tag[1], "!--");
ok($tag[2], 1);
ok($tag[3], 1);
