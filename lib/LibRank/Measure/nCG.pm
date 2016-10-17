package LibRank::Measure::nCG;
use Moose;
use namespace::autoclean;

extends 'LibRank::Measure::CG';
with 'LibRank::Measure::Role::MaxNorm';

__PACKAGE__->meta->make_immutable;
