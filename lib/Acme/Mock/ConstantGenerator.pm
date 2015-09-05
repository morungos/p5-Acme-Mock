package Acme::Mock::ConstantGenerator;

use strict;
use warnings;

use Moose;

extends 'Acme::Mock::Generator';

## Ignore all values in get

sub get {
  my ($self, $main, $context) = @_;
  return $self->get_selected();
}

## =====================================================================
## Return the selected value

sub get_selected {
  my ($self) = @_;
  return $self->values()->[0];
}

## =====================================================================
## Reset is meaningless

sub reset {
  my ($self) = @_;
}

## =====================================================================
## And so is randomize

sub randomize {
  my ($self) = @_;
}

## =====================================================================
## Stepping is never an issue

sub step_with_wrap {
  my ($self) = @_;
  return 0;
}
