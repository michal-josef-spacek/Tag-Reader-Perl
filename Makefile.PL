# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'Tag::Reader::Perl',
	'PREREQ_PM' => {
		'Class::Utils' => 0.01,
		'Error::Simple::Multiple' => 0.05,
		'File::Object' => 0,
	},
	'VERSION_FROM' => 'Perl.pm',
	'test' => {
		'TESTS' => 't/Tag::Reader::Perl/*.t',
	},
);
