# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: Conditional test.\n" if $debug;
my $obj = $class->new;
$obj->set_file($test_dir.'/data/conditional1.tags');
my @tag = $obj->gettoken;
ok($tag[0], '<![%foo[<!ELEMENT foo EMPTY>]]>');
ok($tag[1], '![%foo[');
ok($tag[2], 1);
ok($tag[3], 1);

$obj = $class->new;
$obj->set_file($test_dir.'/data/conditional2.tags');
@tag = $obj->gettoken;
ok($tag[0], '<![ %foo [<!ELEMENT foo EMPTY>]]>');
ok($tag[1], '![');
ok($tag[2], 1);
ok($tag[3], 1);
