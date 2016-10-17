package LibRank::Measure::Role::MaxNorm;
use Moose::Role;
use namespace::autoclean;

requires 'max';


around 'calc' => sub {
  my $orig = shift;
  my $self = shift;
  my $docs = shift;

  my $max = $self->max;
  return $max != 0 ? $self->$orig($docs)/$max : 0;
};


1;
