unit module XML::Expat;

use XML::Expat::Bindings;
use NativeCall;

sub begin ($a, $tag, $attr) {
  
}


sub from-xml(Str $xml) is export {
  my sub begin-element ($a, $tag, $attr) {

  };
  my sub end-element ($a, $tag) {

  };
  $xml.say;
}
