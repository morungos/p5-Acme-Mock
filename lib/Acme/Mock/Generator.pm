package Acme::Mock::Generator;

use strict;
use warnings;

use Moose;

## =====================================================================
## Attributes

has name => (
  is  => 'rw',
  isa => 'Str',
);

has index => (
  is  => 'rw',
  isa => 'Int',
  default => 0,
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

sub initialize {
  my ($self, $main) = @_;
  push @{$main->sorted_generators()}, $self;
  for my $child (@{$self->children()}) {
    $child->initialize($main);
  }
}

## =====================================================================
## The main entry point

sub get {
  my ($self) = @_;
  my $current = $self->get_selected();
  my $children = {this => $current};
  for my $child (@{$self->children()}) {
    my $child_name = $child->name();
    my $child_value = $child->get();
    $children->{$child_name} = $child_value;
  }
  return $self->format($children);
}

## =====================================================================
## Return the selected value

sub get_selected {
  my ($self) = @_;
  $self->values()->[$self->index()];
}

## =====================================================================
## A linear reset sets all the values to zero, the initial entry in any
## generated list.

sub reset {
  my ($self) = @_;
  $self->index(0);
  for my $child (@{$self->children()}) {
    $child->reset();
  }
};

## =====================================================================
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

## =====================================================================
## Teh stepper

sub step_with_wrap {
  my ($self) = @_;
  my $index = $self->index();
  my $length = @{$self->values()};
  $index = $index + 1;
  if ($index >= $length) {
    $self->index(0);
    return 1;
  } else {
    return 0;
  }
}

1;
