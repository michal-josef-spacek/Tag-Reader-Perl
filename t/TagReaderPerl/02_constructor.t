# $Id: 02_constructor.t,v 1.1 2005-08-20 06:02:48 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: new() bad plain constructor.\n" if $debug;
my $obj;
eval {
	$obj = $class->new;
};
$@ =~ s/(.*)\ at.*\n/$1/;
ok($@, 'Usage: Tag::Reader::new(class, filename)');

print "Testing: Right new(filename) constructor.\n" if $debug;
$obj = $class->new($test_dir.'/data/start_tag1.tags');
ok(defined $obj, 1);
ok($obj->isa($class), 1);
ok($obj, qr/$class/);
