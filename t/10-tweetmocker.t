use Test::More tests => 1;

use strict;
use warnings;

use Acme::Mock::TweetMocker;

my $mocker = Acme::Mock::TweetMocker->new();
$mocker->reset();

is($mocker->mock(), "More hopeless than a basket of Kardashians");

1;
