xquery version "1.0-ml";

module namespace json = "http://marklogic.com/roxy/simple-json-lib";

declare namespace search = "http://marklogic.com/appservices/search";

declare default element namespace "http://www.w3.org/1999/xhtml";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

declare variable $newLineRegex := concat("[", codepoints-to-string((13, 10)), "]+");

(:inner object 
   will create a JSON object which has no inner object inside (a leaf in json)
   oa(("key", "value")) -> {"key":"value"}
:)
declare function json:io($keyValues as item()*) as xs:string {
  string-join(('{', string-join((
  (for $key at $pos in $keyValues
     return
     if($pos mod 2 != 0)
     then string-join(('"',$key,'":','"',json:escapeJSONString(xs:string($keyValues[$pos + 1])),'"'),"")
     else ()
  )),","),'}'),"")
};

(: object
   will create a JSON object which has inner objects inside (an intermediary node in json)
   o(("key",io(("key-value","value")))) -> {"key":{"key-value":"value"}}
:)
declare function json:o($keyValues as item()*) as xs:string {
  string-join(('{', string-join((
  (for $key at $pos in $keyValues
     return
     if($pos mod 2 != 0)
     then string-join(('"',$key,'":',xs:string($keyValues[$pos + 1])),"")
     else ()
  )),","),'}'),"")
};

(: inner value
   will create a leaf in an object created by using o((...))
   o(("key",io(("key-value","value")),"key-1",iv("value-1"))) -> {"key":{"key-value":"value"},"key-1":"value-1"}
:)
declare function json:iv($value as xs:string?) as xs:string {
  string-join(('"',json:escapeJSONString(xs:string($value)),'"'),"")
};

(: simple array
   will create a JSON array which contains simple objects
   o(("key",sa(("value-1", "value-2")))) -> {"key":["value-1", "value-2"]}
:)
declare function json:sa($values as item()*) as xs:string {
  string-join(('[', string-join((
  (for $value in $values
     return
     string-join(('"',json:escapeJSONString(xs:string($value)),'"'),"")
     
  )),","),']'),"")
};

(: object array
   will create a JSON array which contains more complex JSON objects
   o(("key",oa((io(("key-1", "value-1")),io(("key-2", "value-2"))))) -> {"key":[{"key-1":"value-1"},{"key-2":"value-2"}]}
:)
declare function json:oa($values as item()*) as xs:string {
  string-join(('[', string-join((
  ($values
  )),","),']'),"")
};

(: Need to backslash escape any double quotes, backslashes :)
declare private function json:escapeJSONString(
    $string as xs:string
) as xs:string
{
    let $string := replace($string, "(\\|"")", "\\$1")
    let $string := replace($string, $newLineRegex, "")
    let $string := replace($string, codepoints-to-string(9), "\\t")
    return $string
};