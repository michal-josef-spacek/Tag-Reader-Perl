# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'AUTHOR' => 'Michal Špaček <skim@cpan.org>',
	'NAME' => 'Tag::Reader::Perl',
	'PREREQ_PM' => {
		'Class::Utils' => 0.01,
		'Error::Pure' => 0.01,
		'File::Object' => 0,
	},
	'VERSION_FROM' => 'Perl.pm',
	'test' => {
		'TESTS' => 't/Tag::Reader::Perl/*.t',
	},
);
