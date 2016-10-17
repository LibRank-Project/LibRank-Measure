package LibRank::Measure::nDCG;
use Moose;
use namespace::autoclean;

extends 'LibRank::Measure::DCG';
with 'LibRank::Measure::Role::MaxNorm';

__PACKAGE__->meta->make_immutable;
