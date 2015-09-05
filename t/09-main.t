use Test::More tests => 12;

use strict;
use warnings;

use Acme::Mock;
use Acme::Mock::TemplateGenerator;

my $gen1 = Acme::Mock::TemplateGenerator->new();
$gen1->name("test");
$gen1->values(["A", "B", "C"]);
$gen1->template("Value: {{this}} -- {{child}}");

my $gen2 = Acme::Mock::TemplateGenerator->new();
$gen2->name("child");
$gen2->values(["D", "E", "F"]);
$gen2->template("Sub: {{this}}");

$gen1->children([$gen2]);

my $main = Acme::Mock->new();
$main->root($gen1);
$main->initialize();

is($main->mock(), "Value: A -- Sub: D");
is($main->mock(), "Value: A -- Sub: E");
is($main->mock(), "Value: A -- Sub: F");
is($main->mock(), "Value: B -- Sub: D");
is($main->mock(), "Value: B -- Sub: E");
is($main->mock(), "Value: B -- Sub: F");
is($main->mock(), "Value: C -- Sub: D");
is($main->mock(), "Value: C -- Sub: E");
is($main->mock(), "Value: C -- Sub: F");

is_deeply($main->used_offsets(), [0, 1]);

is($gen1->child_offset(), 0);
is($gen2->child_offset(), 1);

1;
