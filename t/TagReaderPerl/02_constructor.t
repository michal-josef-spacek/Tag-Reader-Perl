# $Id: 02_constructor.t,v 1.3 2005-08-22 16:17:54 skim Exp $

# Test directory.
my $test_dir = "$ENV{'PWD'}/t/TagReaderPerl";

print "Testing: new() bad plain constructor.\n" if $debug;
$obj = $class->new;
ok(defined $obj, 1);
ok($obj->isa($class), 1);
ok($obj, qr/$class/);
