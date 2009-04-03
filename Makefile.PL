# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'Tag::Reader::Perl',
	'PREREQ_PM' => {
		'Error::Simple::Multiple' => 0.05,
	},
	'VERSION_FROM' => 'Perl.pm',
	'test' => {
		'TESTS' => 't/Tag::Reader::Perl/*.t',
	},
);
