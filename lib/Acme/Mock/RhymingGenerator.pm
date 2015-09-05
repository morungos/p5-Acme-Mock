package Acme::Mock::RhymingGenerator;

use strict;
use warnings;

use Moose;

use Text::DoubleMetaphone qw(double_metaphone);

extends 'Acme::Mock::FilteredGenerator';

sub get_filtered_values {
  my ($self, $match, $all_values) = @_;
  my ($phonetic) = double_metaphone($match);

  return [ map {
    my ($second) = double_metaphone($_);
    if (substr($phonetic, 0, 1) eq substr($second, 0, 1)) {
      ($_);
    } else {
      ();
    }
  } @$all_values ]
}

1;
