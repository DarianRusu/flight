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
declare function a:distance-over-delays(){
    <results>
        <arrivals>{
            for $distance in fn:distinct-values(//DistanceGroup)
            order by fn:number($distance)
            return(
                <item>
                    <avg-delay>{ cts:avg-aggregate(
                    cts:element-reference(xs:QName("ArrDelay"))
                    ,(),cts:element-value-query(xs:QName("DistanceGroup"),
                            $distance))
                    }</avg-delay>
                    <distance>{$distance}</distance>
                </item>)
        }</arrivals>
        <departures>{
            for $distance in fn:distinct-values(//DistanceGroup)
            order by fn:number($distance)
            return(<item>
                        <avg-delay>{ cts:avg-aggregate(
                                cts:element-reference(xs:QName("DepDelay"))
                                ,(),cts:element-value-query(xs:QName("DistanceGroup"),
                                        $distance))
                        }</avg-delay>
                        <distance>{$distance}</distance>
                    </item>)
        }</departures>
    </results>
};
declare function a:time-block-over-delays(){
    <results>
        <arrivals>{
            for $group in fn:distinct-values(//ArrivalDelayGroups)
            order by fn:number($group)
            return(
               <item>
                    <count>{ fn:count(//ArrivalDelayGroups[. eq $group])}</count>
                    <interval>{$group}</interval>
               </item>)
        }</arrivals>
        <departures>{
            for $group in fn:distinct-values(//DepartureDelayGroups)
            order by fn:number($group)
            return(
                <item>
                    <count>{ fn:count(//DepartureDelayGroups[. eq $group])}</count>
                    <interval>{$group}</interval>
                </item>)
        }</departures>
    </results>
};
declare function a:aiport-delays(){
    let $temp :=
        <results>{
            for $airport in fn:distinct-values(//Origin)
            order by $airport
            return
                <item>
                    <avg-delay-dep>{fn:format-number(xs:integer(
                            cts:avg-aggregate(
                                    cts:element-reference(xs:QName("DepDelay"))
                                    ,(),cts:element-value-query(xs:QName("Origin"),
                                            $airport))
                    ),"#,##0.00")
                    }</avg-delay-dep>
                    <on-time>{fn:count(//Origin[. eq $airport and //DepDelay le 0])}</on-time>
                    <late>{fn:count(//Origin[. eq $airport and //DepDelay gt 0])}</late>
                    <total>{fn:count(//Origin[. eq $airport])}</total>
                    <carrier>{$airport}</carrier>
                </item>
        }</results>
    return <results>
        {
            for $item in $temp/item
            return <item>
                <avg-delay>{$item/avg-delay-dep}</avg-delay>
                <on-time>{$item/on-time * 100 div $item/total}</on-time>
                <late>{$item/late * 100 div $item/total}</late>
                <airport>{$item/carrier}</airport>
            </item>

        }
    </results>
};