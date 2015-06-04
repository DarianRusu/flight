xquery version "1.0-ml";

import module namespace cpf = "http://marklogic.com/cpf" at "/MarkLogic/cpf/cpf.xqy";
import module namespace l = "http://marklogic.com/roxy/models/lookup-data" at "/app/models/lookup-data.xqy";

declare variable $cpf:document-uri as xs:string external;
declare variable $cpf:transition as node() external;

if (cpf:check-transition($cpf:document-uri,$cpf:transition))
then try {
      l:add-carrier-info($cpf:document-uri),
      l:add-airline-info($cpf:document-uri),
      xdmp:log( "add lookup ran OK" ),
      cpf:success( $cpf:document-uri, $cpf:transition, () )
    }
    catch ($e) {
      cpf:failure( $cpf:document-uri, $cpf:transition, $e, () )
}
else ()
