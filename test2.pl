#!/usr/bin/env perl6

use lib 'lib';
use XML::Expat;

from-xml(q:to/END/
  <xml>
    <a>
      <one parent="a1" />
    </a>
    <b>
      <two />
    </b>
  </xml>
  END
);
