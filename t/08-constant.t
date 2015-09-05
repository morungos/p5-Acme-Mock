use Test::More tests => 2;

use strict;
use warnings;

use Acme::Mock;
use Acme::Mock::ConstantGenerator;

my $main = Acme::Mock->new();

my $gen1 = Acme::Mock::ConstantGenerator->new();
$gen1->name("test");
$gen1->values(["Kardashians"]);

my $context = {};
my $result;

is($gen1->get($main, $context), "Kardashians");
$gen1->index(1);
is($gen1->get($main, $context), "Kardashians");

1;
