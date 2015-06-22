xquery version "1.0-ml";

module namespace c = "http://marklogic.com/roxy/models/carrier-delays-lib";

declare function c:get-carrier-delays(){
    <results>{
        for $carrier in fn:distinct-values(//AirlineDescription)
        order by $carrier
        return
            <item>
                <avg-delay-arr>{fn:format-number(xs:integer(
                        cts:avg-aggregate(
                                cts:element-reference(xs:QName("ArrDelay"))
                                ,(),cts:element-value-query(xs:QName("AirlineDescription"),
                                        $carrier))
                ),"#,##0.00")
                }</avg-delay-arr>
                <avg-delay-dep>{fn:format-number(xs:integer(
                        cts:avg-aggregate(
                                cts:element-reference(xs:QName("DepDelay"))
                                ,(),cts:element-value-query(xs:QName("AirlineDescription"),
                                        $carrier))
                ),"#,##0.00")
                }</avg-delay-dep>
                <carrier>{$carrier}</carrier>
            </item>
    }</results>
};

