package Acme::Mock;

# ABSTRACT: A general purpose mocking module

use strict;
use warnings;

use Moose;

use Acme::Mock::Generator;

has root => (
  is  => 'rw',
  isa => 'Acme::Mock::Generator',
);

has sorted_generators => (
  is  => 'rw',
  isa => 'ArrayRef[Acme::Mock::Generator]',
);

## =====================================================================
## Builds a depth-sorted array

sub initialize {
  my ($self) = @_;
  $self->sorted_generators([]);
  $self->root()->initialize($self);
}

## =====================================================================
## Steps backwards through the sorted generators, and stops as soon as it
## finds one which doesn't wrap

sub step {
  my ($self) = @_;
  my $children = $self->sorted_generators();
  my $last;
  for(my $i = $#$children; $i >= 0; $i--) {
    last unless $last = $children->[$i]->step_with_wrap();
  }
  return $last;
}

## =====================================================================
## Reset method

sub reset {
  my ($self) = @_;
  $self->root()->reset();
}

## =====================================================================
## Randomize method

sub randomize {
  my ($self) = @_;
  $self->root()->randomize();
}

## =====================================================================
## Main mocking method

sub mock {
  my ($self) = @_;
  my $result = $self->root()->get();
  $self->step();
  return $result;
}

1;
