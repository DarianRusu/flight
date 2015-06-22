xquery version "1.0-ml";

module namespace ext = "http://marklogic.com/rest-api/resource/hourly-delays";

declare namespace roxy = "http://marklogic.com/roxy";

import module namespace w = "http://marklogic.com/roxy/models/hourly-delays-lib" at "/app/models/hourly-delays-lib.xqy";
import module namespace s = "http://marklogic.com/roxy/models/static" at "/app/models/static.xqy";
import module namespace wj = "http://marklogic.com/roxy/views/hourly-delays.json" at "/app/views/hourly-delays.json.xqy";


(: 
 : To add parameters to the functions, specify them in the params annotations. 
 : Example
 :   declare %roxy:params("uri=xs:string", "priority=xs:int") ext:get(...)
 : This means that the get function will take two parameters, a string and an int.
 :)

(:
 :)
declare 
%roxy:params("")
function ext:get(
  $context as map:map,
  $params  as map:map
) as document-node()*
{
  map:put($context, "output-types", "application/xml"),
  xdmp:set-response-code(200, "OK"),
  document { wj:delays-json(s:static-hourly()) }
};

(:
 :)
declare 
%roxy:params("")
function ext:put(
    $context as map:map,
    $params  as map:map,
    $input   as document-node()*
) as document-node()?
{
  map:put($context, "output-types", "application/xml"),
  xdmp:set-response-code(200, "OK"),
  document { "PUT called on the ext service extension" }
};

(:
 :)
declare 
%roxy:params("")
function ext:post(
    $context as map:map,
    $params  as map:map,
    $input   as document-node()*
) as document-node()*
{
  map:put($context, "output-types", "application/xml"),
  xdmp:set-response-code(200, "OK"),
  document { "POST called on the ext service extension" }
};

(:
 :)
declare 
%roxy:params("")
function ext:delete(
    $context as map:map,
    $params  as map:map
) as document-node()?
{
  map:put($context, "output-types", "application/xml"),
  xdmp:set-response-code(200, "OK"),
  document { "DELETE called on the ext service extension" }
};
