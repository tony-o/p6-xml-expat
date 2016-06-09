unit module XML::Expat;

use XML::Document;
use XML::Text;
use XML::Comment;
use XML::Element;
use XML::CDATA;
use XML::Expat::Bindings;
use NativeCall;

sub from-xml(Str $xml) is export {
  my XML::Document $doc;
  my $indent             = 0;
  my int32 $z;
  my $parser             = XML_ParserCreate($z);

  my ($current-node, $doctype, $version, $encoding);
  
  my sub begin-element ($a, $tag, $attr) {
    my $c           = 0;
    my $attribs     = { };
    my $attributes := nativecast(CArray[Str], $attr);
    
    while $attributes[$c].defined {
      $attribs{$attributes[$c].Str} = $attributes[$c+1].Str;
      $c += 2;
    }
    my $element = XML::Element.new(name => $tag, :$attribs);
    if !$doc.defined {
      $doc .=new(root => $element, :$doctype, :$version, :$encoding);
    } else {
      $current-node.append($element);
    }
    $current-node = $element;
  };
  my sub end-element ($a, $tag) {
    $current-node = $current-node.parent;
  };
  my sub comment-handler ($x, $data) {
    $current-node.append(XML::Comment.new(:$data));
  };
  my sub cdata-handler ($x, $data) {
    $current-node.append(XML::CDATA.new(:$data));
  };
  my sub text-handler ($x, $y, $z) {
    return if $z == 0;
    my $text = $y.substr(0, $z).trim;
    $current-node.append(XML::Text.new(:$text));
  };
  my sub start-doctype ($x, $name, $sysid, $pubid, $internal-subset) {
    $doctype.type  = $name;
    $doctype.value = $sysid;
  };
  my sub end-doctype ($x) { };

  my sub decl-doctype ($x, $version, $encoding, $standalone) {
    $encoding = $encoding;
    $version  = $version;
  };

  XML_SetXmlDeclHandler($parser, &decl-doctype);
  XML_SetElementHandler($parser, &begin-element, &end-element);
  XML_SetCommentHandler($parser, &comment-handler);
  XML_SetCharacterDataHandler($parser, &text-handler);
  XML_SetDoctypeDeclHandler($parser, &start-doctype, &end-doctype);

  XML_Parse($parser, $xml, $xml.chars, 1);

  $doc.perl.say;
  $doc.Str.say;
}
