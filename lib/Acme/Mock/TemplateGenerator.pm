package Acme::Mock::TemplateGenerator;

use strict;
use warnings;

use Moose;

extends 'Acme::Mock::Generator';

## =====================================================================
## Attributes

has template => (
  is  => 'rw',
  isa => 'Str',
);

## =====================================================================
## The default formatter
sub format {
  my ($self, $keys) = @_;
  my $template = $self->template();
  while ($template =~ s/\{\{\s*(\w+)\s*\}\}/ $keys->{$1}; /eg) { };
  return $template;
}

1;
