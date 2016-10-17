package LibRank::Measure::Func;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(dcg dcg_dv ERR prec qrel_vector);

use List::Util qw(sum);

# DCG with discount log2(r+1)
sub dcg {
  my $self = shift;
  my $gains = shift;
  my $k = shift;

  my @discount = map { log($_[0]+1)/log(2) } 1..$k;
  return dcg_dv($gains, \@discount);
}

# Helper function to calculate DCG with custom $discount_vector.
# This allows to reuse/cache the calculation of the discounts.
sub dcg_dv {
  my $gains = shift;
  my $discount_vector = shift;
  my $k = shift;

  return sum(map { $gains->[$_] * 1/$discount_vector->[$_] } 0..$k-1);
}


sub ERR {                    
  my $prob = shift;
  my $p = 1;
  my $ERR = 0;               
  foreach my $r(1..scalar(@$prob)){
    my $R = $prob->[$r-1];
    $ERR += $p * $R/$r;      
    $p *= (1-$R);            
  }     
  return $ERR;
}

sub prec {
  my $rel = shift; # [(0|1), ...]
  my $k = shift;

  return sum(@$rel[0..$k-1])/$k;
}

sub qrel_vector {
  my $docs = shift;
  my $qrel = shift;
  my $k = shift;
  my $condensed = shift // 1;

  # create list of qrels
  # ignore unjudged documents by default (i.e. use a condensed list).
  # see doi:10.1007/s10791-008-9059-7
  my @qrel;
  my $unjudged = 0;
  foreach my $id (@{$docs}) {
    my $q = $qrel->{$id};
    push @qrel, $q if defined($q) or not $condensed;
	$unjudged++ if not defined($q);
	last if @qrel == $k;
  }
  return { qrel => \@qrel, unjudged => $unjudged };
}
