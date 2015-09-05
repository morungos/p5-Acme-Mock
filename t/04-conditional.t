use Test::More tests => 4;

use strict;
use warnings;

use Acme::Mock;
use Acme::Mock::ConditionalGenerator;
use Acme::Mock::Generator;

## Basic template tests

my $main = Acme::Mock->new();

my $gen1 = Acme::Mock::ConditionalGenerator->new();
$gen1->name("test");
$gen1->values(["yes", "no"]);

my $gen2 = Acme::Mock::Generator->new();
$gen2->name("yes");
$gen2->values(["A", "B", "C"]);

my $gen3 = Acme::Mock::Generator->new();
$gen3->name("no");
$gen3->values(["D", "E", "F"]);

$gen1->children([$gen2, $gen3]);

$main->root($gen1);
$main->initialize();

$main->used_offsets([]);
$gen1->index(0);
is($gen1->get($main), "A");
is_deeply($main->used_offsets(), [0, 1]);

$main->used_offsets([]);
$gen1->index(1);
is($gen1->get($main), "D");
is_deeply($main->used_offsets(), [0, 2]);


1;
