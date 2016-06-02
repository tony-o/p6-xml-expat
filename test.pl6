#!/usr/bin/env perl6


use lib 'lib';
use XML::Expat::Bindings;

my int32 $z;
my $parser = XML_ParserCreate($z);
my $opt    = 0;
XML_SetUserData($parser, $opt);

my $indent = 0;

my sub start-tag ($x, $y, $z) {
  use NativeCall;
#  my $a := nativecast(CArray[Str], $z);
#  my $c = 0;
#  my %attr;
#  while $a[$c].defined {
#    $a[$c+1].perl.say;
#    %attr{$a[$c].Str} = $a[$c+1].Str;
#    $c += 2;
#  }
#  my $attr = %attr.keys.map({ "$_='{%attr{$_}}'" }).join(',');
  "{' ' x (2 * $indent++)}$y\(\$attr)".say;
}

my sub end-tag ($x, $y) {
  "{' ' x (2 * --$indent)}/$y".say;
}

my sub comment-handler ($x, $y) {
  "{' ' x (2 * $indent)}!-- {$y.trim.perl}".say;
}

my sub text-handler ($x, $y, $z) {
  return if $z == 0;
  my $val = $y.substr(0, $z);
  "{' ' x (2 * $indent)}: '{$val}'".say if $val.trim ne ''; 
}

XML_SetElementHandler($parser, &start-tag, &end-tag); 
XML_SetCommentHandler($parser, &comment-handler);
XML_SetCharacterDataHandler($parser, &text-handler);

my $xml = 'z.xml'.IO.slurp;

$xml.say;

XML_Parse($parser, $xml, $xml.chars, 1);
