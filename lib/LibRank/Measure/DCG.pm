package LibRank::Measure::DCG;
use Moose;
use namespace::autoclean;

use LibRank::Measure::Func qw(dcg_dv qrel_vector);

extends 'LibRank::Measure::Base';

has 'k' => (is => 'ro', default => 10);
has 'discount' => (is => 'ro', builder => '_build_discount');
has '_discount_vector' => (is => 'ro', lazy => 1, builder => '_build__discount_vector');
has 'max' => (is => 'ro', lazy => 1, builder => '_build_max');

sub _build_discount {
  return sub { log($_[0]+1)/log(2); };
}

sub _build__discount_vector {
  my $self = shift;
  return [ map { $self->discount->($_) } 1..($self->k) ];
}

sub _build_max {
  my $self = shift;

  my $qrel = $self->qrel;
  return dcg_dv([ sort { $b <=> $a } values %$qrel ], $self->_discount_vector, $self->k);
}

sub calc {
  my $self = shift;
  my $docs = shift;

  my $qv = qrel_vector($docs, $self->qrel, $self->k, $self->condensed);
  dcg_dv($qv->{qrel}, $self->_discount_vector, $self->k);
}

__PACKAGE__->meta->make_immutable;
