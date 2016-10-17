use Module::Build;
use Module::Build::Prereqs::FromCPANfile;

my $build = Module::Build->new(
  module_name => 'LibRank::Measure',
  dist_version => '0.01',
  dist_abstract => 'Performance measures',
  dist_author   => 'KPL',
  mb_prereqs_from_cpanfile()
);
$build->create_build_script;
