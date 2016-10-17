package LibRank::Measure::Base;
use Moose;
use namespace::autoclean;

has 'qrel' => (is => 'ro', required => 1);
has 'condensed' => (is => 'ro', default => 1);

sub calc {
  my $self = shift;
  my $docs = shift;

  die 'Not implemented';
}

__PACKAGE__->meta->make_immutable;
