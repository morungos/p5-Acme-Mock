package Acme::Mock::TweetMocker;

use strict;
use warnings;

use Moose;

use Acme::Mock;
use Acme::Mock::TemplateGenerator;
use Acme::Mock::Generator;

extends 'Acme::Mock';

sub BUILD {
  my ($self) = @_;

  my $qualities = Acme::Mock::Generator->new();
  $qualities->name('quality');
  $qualities->values([ 'hopeless', 'oblivious', 'deluded', 'incompetent',
                       'clueless', 'incoherent', 'thoughtless', 'naive',
                       'ignorant', 'dense', 'dopey', 'witless', 'inept',
                       'cack-handed' ]);

  my $intro = Acme::Mock::Generator->new();
  $intro->name('intro');
  $intro->values(['as {{quality }} as', 'more {{quality}} than']);

  my $animals = Acme::Mock::Generator->new();
  $animals->name('animal');
  $animals->values([ 'Kardashians', 'scientologists', 'buffoons', 'politicians',
                     'badgers', 'kittens', 'puppies', 'gamergaters',
                     'stick insects', 'starfish', 'wallabies', 'lemurs',
                     'armadilloes', 'aardvarks', 'weasels', 'stoats', 'cops',
                     'dormice', 'cuckoos' ]);

  my $collectives = Acme::Mock::Generator->new();
  $collectives->name('collective');
  $collectives->values([ 'basket', 'box', 'crate', 'cart', 'shoal', 'swarm',
                         'school', 'raft', 'rabble', 'punnet', 'pod', 'posse',
                         'mob', 'troop', 'clutch', 'brace', 'stack',
                         'warehouse', 'armada', 'bundle', 'pile', 'heap',
                         'parcel' ]);

  my $template = Acme::Mock::TemplateGenerator->new();
  $template->template("{{intro}} a {{collective}} of {{animal}}");
  $template->children([$qualities, $intro, $animals, $collectives]);

  $self->root($template);
  $self->initialize();
};

1;
