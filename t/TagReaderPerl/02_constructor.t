# $Id: 02_constructor.t,v 1.4 2005-08-27 13:50:53 skim Exp $

print "Testing: new() bad plain constructor.\n" if $debug;
$obj = $class->new;
ok(defined $obj, 1);
ok($obj->isa($class), 1);
ok($obj, qr/$class/);
