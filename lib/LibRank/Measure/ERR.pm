package LibRank::Measure::ERR;
use Moose;
use namespace::autoclean;

use LibRank::Measure::Func qw(ERR qrel_vector);

extends 'LibRank::Measure::Base';

has 'k' => (is => 'ro', default => 10);
has 'max' => (is => 'ro', init_arg => undef, lazy => 1, builder => '_build_max');
has 'prob' => (is => 'ro', lazy => 1, builder => '_build_prob');
has 'probs' => (is => 'ro', lazy => 1, builder => '_build_probs');

sub _build_prob {
  my $self = shift;
  # default conversion for qrel: [0,100]
  # Note: ERR for ordinal qrels caps the max probabilty (p < 1).
  return sub { $_[0] / 100 };
}

sub _build_probs {
  my $self = shift;
  my $qrel = $self->qrel;

  return { map { $_ => $self->prob->($qrel->{$_}) } keys %$qrel };
}

sub _build_max {
  my $self = shift;

  my $p = $self->probs;
  my @p = sort { $b <=> $a } values %$p;
  return ERR([ @p[0..$self->k-1] ]);
}

sub calc {
  my $self = shift;
  my $docs = shift;

  my $qv = qrel_vector($docs, $self->probs, $self->k, $self->condensed);
  return ERR($qv->{qrel});
}

__PACKAGE__->meta->make_immutable;
