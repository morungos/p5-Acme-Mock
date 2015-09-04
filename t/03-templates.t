use Test::More tests => 3;

use strict;
use warnings;

use Acme::Mock::TemplateGenerator;

## Basic template tests

my $gen1 = Acme::Mock::TemplateGenerator->new();
$gen1->name("test");
$gen1->values(["A", "B", "C"]);
$gen1->template("Value: {{this}}");

is($gen1->get(), "Value: A");

$gen1->index(1);
is($gen1->get(), "Value: B");

## Hierarchical template tests

my $gen2 = Acme::Mock::TemplateGenerator->new();
$gen2->name("child");
$gen2->values(["D", "E", "F"]);
$gen2->template("Sub: {{this}}");

$gen1->template("Value: {{this}} -- {{child}}");

$gen1->index(0);
$gen2->index(2);

$gen1->children([$gen2]);

is($gen1->get(), "Value: A -- Sub: F");

1;
