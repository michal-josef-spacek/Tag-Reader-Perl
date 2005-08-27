# $Id: 02_constructor.t,v 1.5 2005-08-27 18:33:25 skim Exp $

print "Testing: new('') bad constructor.\n" if $debug;
my $obj;
eval {
	$obj = $class->new('');
};
ok($@, "$class: Unknown parameter ''.\n");

print "Testing: new('something' => 'value') bad constructor.\n" if $debug;
eval {
	$obj = $class->new('something' => 'value');
};
ok($@, "$class: Unknown parameter 'something'.\n");

print "Testing: new() right plain constructor.\n" if $debug;
$obj = $class->new;
ok(defined $obj, 1);
ok($obj->isa($class), 1);
ok($obj, qr/$class/);
