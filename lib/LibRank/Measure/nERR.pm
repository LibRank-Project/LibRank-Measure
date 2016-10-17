package LibRank::Measure::nERR;
use Moose;
use namespace::autoclean;

extends 'LibRank::Measure::ERR';
with 'LibRank::Measure::Role::MaxNorm';

__PACKAGE__->meta->make_immutable;
