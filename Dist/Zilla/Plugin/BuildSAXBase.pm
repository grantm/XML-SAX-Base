package Dist::Zilla::Plugin::BuildSAXBase;
use Moose;
with 'Dist::Zilla::Role::FileGatherer';

use Dist::Zilla::File::InMemory;

sub gather_files {
  my ($self) = @_;

  # Remove manually generated version if it exists

  my $path = File::Spec->catfile("lib", "XML", "SAX", "Base.pm");
  unlink($path) if -e $path;


  # Generate a new in-memory version

  require "BuildSAXBase.pl";
  $self->add_file(
    Dist::Zilla::File::InMemory->new(
      name => 'lib/XML/SAX/Base.pm',
      content => SAX::Base::Builder::build_xml_sax_base(),
    )
  );
}

1;
