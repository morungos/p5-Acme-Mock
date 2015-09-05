use Test::More tests => 3;

use strict;
use warnings;

use Acme::Mock;
use Acme::Mock::TemplateGenerator;

my $main = Acme::Mock->new();

my $gen1 = Acme::Mock::TemplateGenerator->new();
$gen1->name("test");
$gen1->values(["A", "B", "C"]);
$gen1->template("Value: {{this}} -- {{child}}");

my $gen2 = Acme::Mock::TemplateGenerator->new();
$gen2->name("child");
$gen2->values(["D", "E", "F"]);
$gen2->template("Sub: {{this}}");

my $gen3 = Acme::Mock::TemplateGenerator->new();
$gen3->name("second");
$gen3->values(["G", "H", "I"]);
$gen3->template("{{this}}");

$gen1->index(0);
$gen2->index(0);
$gen3->index(0);

$gen1->children([$gen2, $gen3]);

my $context = {};
$gen1->get($main, $context);

is($context->{this}, "A");
is($context->{child}, "Sub: D");
is($context->{second}, "G");

1;
