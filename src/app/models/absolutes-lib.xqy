xquery version "1.0-ml";

module namespace a = "http://marklogic.com/roxy/models/absolutes-lib";

declare function a:absolutes(){
    let $cAd := xdmp:estimate(/flight[./ArrDelay gt 0])
    let $cAot := xdmp:estimate(/flight[./ArrDelay le 0])
    let $cAtotal := fn:sum(($cAd,$cAot))

    let $cDd := xdmp:estimate(/flight[./DepDelay gt 0])
    let $cDot := xdmp:estimate(/flight[./DepDelay le 0])
    let $cDtotal := fn:sum(($cAd,$cAot))
    let $pAd := ($cAd * 100) div $cAtotal
    let $pAot := ($cAot * 100) div $cAtotal
    let $pDd := ($cDd * 100) div $cDtotal
    let $pDot := ($cDot * 100) div $cDtotal
    let $total := fn:sum((fn:count(//CarrierDelay[. ne "" and . ne 0]),
    fn:count(//WeatherDelay[. ne "" and . ne 0]),
    fn:count(//SecurityDelay[. ne "" and . ne 0]),
    fn:count(//NASDelay[. ne "" and . ne 0]),
    fn:count(//LateAircraftDelay[. ne "" and . ne 0])))
    return
        <result>
            <max-dep-delay>{cts:max(cts:element-reference(xs:QName("DepDelay")))}</max-dep-delay>
            <max-arr-delay>{cts:max(cts:element-reference(xs:QName("ArrDelay")))}</max-arr-delay>
            <longest-flight>{cts:max(cts:element-reference(xs:QName("AirTime")))}</longest-flight>
            <longest-distance>{cts:max(cts:element-reference(xs:QName("Distance")))}</longest-distance>
            <arrivals>
                <late>{$pAd}</late>
                <on-time>{$pAot}</on-time>
            </arrivals>
            <departures>
                <late>{$pDd}</late>
                <on-time>{$pDot}</on-time>
            </departures>
            <delay-types>
                <carrier>{fn:count(//CarrierDelay[. ne "" and . ne 0]) * 100 div $total}</carrier>
                <weather>{fn:count(//WeatherDelay[. ne "" and . ne 0]) * 100 div $total}</weather>
                <security>{fn:count(//SecurityDelay[. ne "" and . ne 0]) * 100 div $total}</security>
                <NAS>{fn:count(//NASDelay[. ne "" and . ne 0]) * 100 div $total}</NAS>
                <late-aircraft>{fn:count(//LateAircraftDelay[. ne "" and . ne 0]) * 100 div $total}</late-aircraft>
            </delay-types>
        </result>
};
