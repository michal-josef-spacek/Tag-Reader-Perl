# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'Tag::Reader::Perl',
	'VERSION_FROM' => 'Perl.pm',
	'test' => {
		'TESTS' => 't/Tag::Reader::Perl/*.t',
	},
);
