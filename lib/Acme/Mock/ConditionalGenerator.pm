package Acme::Mock::ConditionalGenerator;

use strict;
use warnings;

use Moose;

extends 'Acme::Mock::Generator';

## =====================================================================
## In the case of a ConditionalGenerator, the values select which
## children are used, and a template too. A typical use case is a
## simple alternate. In this case, get_selected returns a hashref
## containing a template and a selected set of children, or maybe
## just a single child.

sub get {
  my ($self, $main) = @_;
  my $used = $main->used_offsets();
  push @$used, $self->child_offset();
  my $current = $self->get_selected();
  return $self->get_named_child($main, $current);
}

1;
