use Test::More tests => 1;

use strict;
use warnings;

use Acme::Mock;
use Acme::Mock::FilteredGenerator;

my $main = Acme::Mock->new();

my $gen1 = Acme::Mock::FilteredGenerator->new();
$gen1->name("test");
$gen1->filter("name");
$gen1->all_values(["Kardashians", "scientologists", "buffoons"]);

my $context = {name => "Kittens"};
my $result = $gen1->get($main, $context);

is($result, "Kardashians");

1;
