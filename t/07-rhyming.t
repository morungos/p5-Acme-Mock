use Test::More tests => 2;

use strict;
use warnings;

use Acme::Mock;
use Acme::Mock::RhymingGenerator;

my $main = Acme::Mock->new();

my $gen1 = Acme::Mock::RhymingGenerator->new();
$gen1->name("test");
$gen1->filter("name");
$gen1->all_values(["Kardashians", "scientologists", "buffoons"]);

my $context = {};
my $result;

$context->{name} = "Swarm";
is($gen1->get($main, $context), "scientologists");

$context->{name} = "crate";
is($gen1->get($main, $context), "Kardashians");

1;
