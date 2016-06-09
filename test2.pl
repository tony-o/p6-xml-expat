#!/usr/bin/env perl6

use lib 'lib';
use XML::Expat;

from-xml(q:to/END/);
<!DOCTYPE document SYSTEM "subjects.dtd">
<xml>
  <a>
    <one parent="a1" />
    <text> this is some text </text>
  </a>
  <b>
    <text> this is b's text </text>
    <two />
  </b>
</xml>
END
