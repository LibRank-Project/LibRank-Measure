package LibRank::Measure::Scorer;
use Moose;
use namespace::autoclean;

has 'measures' => (is => 'ro', default => sub { {} });

sub add {
  my $self = shift;
  my $key = shift;
  my $measure = shift;

  $self->measures->{$key} = $measure;
}

sub score {
  my $self = shift;
  my $docs = shift;

  my %scores = map { $_ => $self->measures->{$_}->calc($docs) } keys %{$self->measures};
  return \%scores;
}

__PACKAGE__->meta->make_immutable;
