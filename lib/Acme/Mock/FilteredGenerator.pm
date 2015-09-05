package Acme::Mock::FilteredGenerator;

use strict;
use warnings;

use Moose;

extends 'Acme::Mock::Generator';

## =====================================================================
## Attributes

has filter => (
  is  => 'rw',
  isa => 'Str',
);

has all_values => (
  is  => 'rw',
  isa => 'ArrayRef',
  default => sub { [] },
);

sub get_filtered_values {
  my ($self, $match, $all_values) = @_;
  return $all_values;
}

before 'get' => sub {
  my ($self, $main, $context) = @_;
  my $values = $self->all_values();
  my $match = $context->{$self->filter()};
  $self->values($self->get_filtered_values($match, $values));
};

1;
