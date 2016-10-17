package LibRank::Measure::CG;
use Moose;
use namespace::autoclean;

use Data::Dumper;
use List::Util qw(sum);
use LibRank::Measure::Func qw(qrel_vector);

extends 'LibRank::Measure::Base';

has 'k' => (is => 'ro', default => 10);
has 'max' => (is => 'ro', lazy => 1, builder => '_build_max');

sub _build_max {
  my $self = shift;

  my $qrel = $self->qrel;
  my @gains = sort { $b <=> $a } values %$qrel;
  return sum(@gains[0..$self->k-1]);
}


sub calc {
  my $self = shift;
  my $docs = shift;

  my $qv = qrel_vector($docs, $self->qrel, $self->k);

  #warn "unjudged: ", $gain->{unjudged};
  #return sum(@{ $gain->{vector}});
  return sum(@{ $qv->{qrel} });
}

__PACKAGE__->meta->make_immutable;
