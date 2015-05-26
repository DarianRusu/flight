xquery version "1.0-ml";

module namespace l = "http://marklogic.com/roxy/models/lookup-data";

declare function l:add-carrier-info($uri as xs:string){
  (:xdmp:log($uri):)

  let $description := cts:search(fn:collection("carriers")
                                ,fn:doc($uri)/flight/Carrier/text()
                                )[1]//Description/text()
  let $arrHour := fn:substring(fn:doc($uri)/flight/ArrTime/text(),1,2)
  let $depHour := fn:substring(fn:doc($uri)/flight/DepTime/text(),1,2)

  return(
      xdmp:node-insert-after(fn:doc($uri)/flight/Carrier,
              <CarrierDescription>{$description}</CarrierDescription>),
      xdmp:node-insert-after(fn:doc($uri)/flight/ArrTime,
              <ArrHour>{$arrHour}</ArrHour>),
      xdmp:node-insert-after(fn:doc($uri)/flight/DepTime,
              <DepHour>{$depHour}</DepHour>)
  )
};

declare function l:add-airline-info($uri as xs:string){

  let $description := cts:search(fn:collection("airlines")
                                ,fn:doc($uri)/flight/AirlineID/text()
                                )[1]//Description/text()


  return xdmp:node-insert-after(fn:doc($uri)/flight/AirlineID,
                                <AirlineDescription>{$description}</AirlineDescription>)
};
