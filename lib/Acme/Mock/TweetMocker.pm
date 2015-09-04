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

  my $animals = Acme::Mock::Generator->new();
  $animals->name('animal');
  $animals->values([ 'Kardashians', 'scientologists', 'buffoons', 'politicians',
                     'badgers', 'kittens', 'puppies', 'gamergaters',
                     'stick insects', 'starfish', 'wallabies', 'lemurs',
                     'armadilloes', 'aardvarks', 'weasels', 'stoats', 'cops',
                     'dormice' ]);

  my $collectives = Acme::Mock::Generator->new();
  $collectives->name('collective');
  $collectives->values([ 'basket', 'box', 'crate', 'cart', 'shoal', 'swarm',
                         'school', 'raft', 'rabble', 'punnet', 'pod', 'posse',
                         'mob' ]);

  my $qualities = Acme::Mock::Generator->new();
  $qualities->name('quality');
  $qualities->values([ 'hopeless', 'oblivious', 'deluded', 'incompetent',
                         'clueless', 'incoherent', 'thoughtless', 'naive' ]);

  my $template = Acme::Mock::TemplateGenerator->new();
  $template->template("More {{quality}} than a {{collective}} of {{animal}}");
  $template->children([$animals, $qualities, $collectives]);

  $self->root($template);
};

1;
