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

has child_offset => (
  is  => 'rw',
  isa => 'Int',
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
  isa => 'ArrayRef',
  default => sub { [] },
);

sub initialize {
  my ($self, $main) = @_;
  my $sorted_generators = $main->sorted_generators();
  push @$sorted_generators, $self;
  $self->child_offset($#$sorted_generators);
  for my $child (@{$self->children()}) {
    $child->initialize($main);
  }
}

## =====================================================================
## The main entry point -- default behaviour uses all children

sub find_named_child {
  my ($self, $name) = @_;
  for my $child (@{$self->children()}) {
    if ($child->name() eq $name) {
      return $child;
    }
  }
}

sub get_named_child {
  my ($self, $main, $name) = @_;
  my $child = $self->find_named_child($name);
  return $child->get($main);
}

sub get_children {
  my ($self, $main, $children, $result) = @_;
  for my $child (@$children) {
    my $child_name = $child->name();
    my $child_value = $child->get($main);
    $result->{$child_name} = $child_value;
  }
  return $result;
}

sub get_all_children {
  my ($self, $main, $result) = @_;
  return $self->get_children($main, $self->children(), $result);
}

sub get {
  my ($self, $main) = @_;
  my $used = $main->used_offsets();
  push @$used, $self->child_offset();
  my $current = $self->get_selected();
  my $values = {this => $current};
  $values = $self->get_all_children($main, $values);
  return $self->format($values);
}

sub format {
  my ($self, $children) = @_;
  return $children->{this};
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
    $self->index($index);
    return 0;
  }
}

1;
