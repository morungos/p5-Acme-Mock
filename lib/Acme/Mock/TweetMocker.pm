package Acme::Mock::TweetMocker;

use strict;
use warnings;

use Moose;

use Acme::Mock;
use Acme::Mock::TemplateGenerator;
use Acme::Mock::ConstantGenerator;
use Acme::Mock::ConditionalGenerator;
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

  my $suffix_absent = Acme::Mock::ConstantGenerator->new();
  $suffix_absent->name("suffix_absent");
  $suffix_absent->values([""]);

  my $suffix_present = Acme::Mock::ConstantGenerator->new();
  $suffix_present->name("suffix_present");
  $suffix_present->values([", but better at singing"]);

  my $suffix = Acme::Mock::ConditionalGenerator->new();
  $suffix->name("suffix");
  $suffix->values(["suffix_absent", "suffix_present"]);
  $suffix->children([$suffix_absent, $suffix_present]);

  my $template = Acme::Mock::TemplateGenerator->new();
  $template->template("{{intro}} a {{collective}} of {{animal}}{{suffix}}");
  $template->children([$qualities, $intro, $animals, $collectives, $suffix]);

  $self->root($template);
  $self->initialize();
};

1;
