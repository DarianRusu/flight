xquery version "1.0-ml";

module namespace c = "http://marklogic.com/roxy/models/hourly-delays-lib";

declare function c:get-hourly-delays(){
    <results>
        <arrivals>{
            for $hour in fn:distinct-values(//ArrHour)
            order by $hour
            return
                <item>
                    <avg-delay>{ cts:avg-aggregate(
                            cts:element-reference(xs:QName("ArrDelayMinutes"))
                            ,(),cts:element-value-query(xs:QName("ArrHour"),
                                    $hour))
                    }</avg-delay>
                    <hour>{$hour}</hour>
                </item>
        }</arrivals>
        <departures>{
            for $hour in fn:distinct-values(//DepHour)
            order by $hour
            return
                <item>
                    <avg-delay>{ cts:avg-aggregate(
                            cts:element-reference(xs:QName("DepDelayMinutes"))
                            ,(),cts:element-value-query(xs:QName("DepHour"),
                                    $hour))
                    }</avg-delay>
                    <hour>{$hour}</hour>
                </item>
        }</departures>
    </results>
};