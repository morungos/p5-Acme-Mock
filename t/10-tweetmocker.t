use Test::More tests => 2;

use strict;
use warnings;

use Acme::Mock::TweetMocker;

my $mocker = Acme::Mock::TweetMocker->new();
$mocker->reset();

my $first = $mocker->mock();
is($first, "More hopeless than a basket of Kardashians");

my $second = $mocker->mock();
isnt($second, $first);

1;
