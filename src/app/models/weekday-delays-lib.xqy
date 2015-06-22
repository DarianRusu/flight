xquery version "1.0-ml";

module namespace c = "http://marklogic.com/roxy/models/weekday-delays-lib";

declare function c:get-weekday-delays(){
    <results>
        <arrivals>{
            for $day in fn:distinct-values(//DayOfWeek)
                order by $day
            return(<avg-delay>{ cts:avg-aggregate(
                    cts:element-reference(xs:QName("ArrDelay"))
                    ,(),cts:element-value-query(xs:QName("DayOfWeek"),
                            $day))
            }</avg-delay>
            ,<weekday>{$day}</weekday>)
        }</arrivals>
        <departures>{
            for $day in fn:distinct-values(//DayOfWeek)
            return(<avg-delay>{ cts:avg-aggregate(
                    cts:element-reference(xs:QName("DepDelay"))
                    ,(),cts:element-value-query(xs:QName("DayOfWeek"),
                            $day))
            }</avg-delay>
            ,<weekday>{$day}</weekday>)
        }</departures>
    </results>
};

declare function c:get-weekday-month-delays(){
    <results>
        <first-month>
            <arrivals>{
                for $day in fn:distinct-values(//DayofMonth)
                order by fn:number($day)
                return(<avg-delay>{ cts:avg-aggregate(
                        cts:element-reference(xs:QName("ArrDelay"))
                        ,(),cts:and-query((cts:element-value-query(xs:QName("DayofMonth"),
                                $day),cts:element-value-query(xs:QName("Month"),
                                "2"))))
                }</avg-delay>
                ,<weekday>{$day}</weekday>)
            }</arrivals>
            <departures>{
                for $day in fn:distinct-values(//DayofMonth)
                order by fn:number($day)
                return(<avg-delay>{ cts:avg-aggregate(
                        cts:element-reference(xs:QName("DepDelay"))
                        ,(),cts:and-query((cts:element-value-query(xs:QName("DayofMonth"),
                                $day),cts:element-value-query(xs:QName("Month"),
                                "2"))))
                }</avg-delay>
                ,<weekday>{$day}</weekday>)
            }</departures>
        </first-month>
        <second-month>
            <arrivals>{
                for $day in fn:distinct-values(//DayofMonth)
                order by fn:number($day)
                return(<avg-delay>{ cts:avg-aggregate(
                        cts:element-reference(xs:QName("ArrDelay"))
                        ,(),cts:and-query((cts:element-value-query(xs:QName("DayofMonth"),
                                $day),cts:element-value-query(xs:QName("Month"),
                                "9"))))
                }</avg-delay>
                ,<weekday>{$day}</weekday>)
            }</arrivals>
            <departures>{
                for $day in fn:distinct-values(//DayofMonth)
                order by fn:number($day)
                return(<avg-delay>{ cts:avg-aggregate(
                        cts:element-reference(xs:QName("DepDelay"))
                        ,(),cts:and-query((cts:element-value-query(xs:QName("DayofMonth"),
                                $day),cts:element-value-query(xs:QName("Month"),
                                "9"))))
                }</avg-delay>
                ,<weekday>{$day}</weekday>)
            }</departures>
        </second-month>
    </results>
};