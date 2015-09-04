package Acme::Mock::Generator;

use strict;
use warnings;

use Moose;

has name => (
  is  => 'rw',
  isa => 'Str',
);

has index => (
  is  => 'rw',
  isa => 'Int',
);

has children => (
  is  => 'rw',
  isa => 'ArrayRef[Acme::Mock::Generator]',
  default => sub { [] },
);

has values => (
  is  => 'rw',
  isa => 'ArrayRef[Str]',
  default => sub { [] },
);

## A linear reset sets all the values to zero, the initial entry in any
## generated list.

sub reset {
  my ($self) = @_;
  $self->index(0);
  for my $child (@{$self->children()}) {
    $child->reset();
  }
};

## A randomized reset sets all the values to some random value, pointing to
## an appropriate index entry.

sub randomize {
  my ($self) = @_;
  my $length = @{$self->values()};
  $self->index(int(rand($length)));
  for my $child (@{$self->children()}) {
    $child->randomize();
  }
};

1;
