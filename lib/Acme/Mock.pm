package Acme::Mock;

# ABSTRACT: A general purpose mocking module

use strict;
use warnings;

my $state = {
  index => 0,
  data => [ (0) x 64 ]
}

sub _get_selector {
  my ($state, $bound) = @_;
  my $index = $state->{index}++;
  return ($state->{data}->{$index} % $bound);
}

sub _reset_state {
  $state->{index} = 0;
}

my $DESCRIPTIONS = [
  "hopeless", "oblivious", "deluded", "incompetent", "clueless"
];

sub _final {
  my ($state) = @_;
}

sub _get_description {
  my ($state) = @_;

}

sub mock {

}


1;
