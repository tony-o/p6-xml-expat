unit module XML::Expat::Bindings;

use NativeCall;

my native XML_Char 
  is repr('P6int') 
  is Int 
  is export
  is ctype('short') { };

class XML-Parser is repr<CPointer> { };

sub XML_ParserCreate(int32) 
  returns XML-Parser
  is native('expat') 
  is export { * };


sub XML_ParserCreateNS(OpaquePointer, XML_Char) 
  returns OpaquePointer
  is native('expat') 
  is export { * };

sub XML_SetElementHandler(
    XML-Parser,
    &start (OpaquePointer, str, OpaquePointer),
    &end (OpaquePointer, str)
  ) 
  returns Pointer[void]
  is native('expat')
  is export { * };

sub XML_Parse(OpaquePointer, Str, int16, int16)
  returns int16
  is native('expat')
  is export { * };

sub XML_SetUserData(OpaquePointer, int32)
  returns Pointer[void] 
  is native('expat')
  is export { * };

sub XML_SetCommentHandler(OpaquePointer, &handler (OpaquePointer, str))
  returns Pointer[void]
  is native('expat')
  is export { * };

sub XML_SetCharacterDataHandler(OpaquePointer, &handler (OpaquePointer, str, int32))
  returns Pointer[void]
  is native('expat')
  is export { * };

sub XML_SetCdataSectionHandler(OpaquePointer, &start (OpaquePointer), &end (OpaquePointer))
  returns Pointer[void]
  is native('expat')
  is export { * };

sub XML_SetDoctypeDeclHandler (OpaquePointer, &start (OpaquePointer, Str, Str, Str, int32), &end (OpaquePointer))
  returns Pointer[void]
  is native('expat')
  is export { * }; 

sub XML_SetXmlDeclHandler(OpaquePointer, &decl (OpaquePointer, Str, Str, int32))
  returns Pointer[void]
  is native('expat')
  is export { * };
