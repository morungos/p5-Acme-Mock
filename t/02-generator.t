use Test::More tests => 8;

use strict;
use warnings;

use Acme::Mock::Generator;

my $gen1 = Acme::Mock::Generator->new();

## Check name read/write
$gen1->name("Test");
is($gen1->name(), "Test");

## Check values read/write
$gen1->values(["A", "B", "C"]);
is_deeply($gen1->values(), ["A", "B", "C"]);

## Check index reset
$gen1->index(2);
$gen1->reset();
is($gen1->index(), 0);

## Check get_selected
is($gen1->get_selected(), "A");
$gen1->index(2);
is($gen1->get_selected(), "C");

## Check randomize
$gen1->randomize();
ok($gen1->index() >= 0);
ok($gen1->index() <= 2);

my $gen2 = Acme::Mock::Generator->new();
$gen2->values(["D", "E", "F"]);

$gen1->children([$gen2]);

## Check child reset
$gen2->index(2);
$gen1->reset();

is($gen2->index(), 0);

1;
