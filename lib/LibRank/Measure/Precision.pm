package LibRank::Measure::Precision;
use Moose;
use namespace::autoclean;

use LibRank::Measure::Func qw(prec qrel_vector);

extends 'LibRank::Measure::Base';

has 'qrel' => (is => 'ro', required => 1);
has 'k' => (is => 'ro', default => 10);

sub calc {
  my $self = shift;
  my $docs = shift;

  my $qrel = qrel_vector($docs, $self->qrel, $self->k);
  return prec($qrel->{qrel}, $self->k);
}

__PACKAGE__->meta->make_immutable;
