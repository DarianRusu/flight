module namespace aj = 'http://marklogic.com/roxy/views/absolutes.json';

import module namespace json = "http://marklogic.com/roxy/simple-json-lib" at "/app/views/helpers/simple-json-lib.xqy";

declare function aj:absolutes-json($results as item()) {

    json:o((
        "maxDepDelay", json:iv(($results/max-dep-delay/fn:string())),
        "maxArrDelay", json:iv(($results/max-arr-delay/fn:string())),
        "longestFlight", json:iv(($results/longest-flight/fn:string())),
        "longestDistance", json:iv(($results/longest-distance/fn:string())),
        "lateArrivalsPer", json:iv(($results/arrivals/late/fn:string())),
        "onTimeArrivalsPer", json:iv(($results/arrivals/on-time/fn:string())),
        "lateDeparturePer", json:iv(($results/departures/late/fn:string())),
        "onTimeDeparturePer", json:iv(($results/departures/on-time/fn:string())),
        "delayTypes", json:oa((
            $results/delay-types/carrier/fn:string(),$results/delay-types/weather/fn:string(),
            $results/delay-types/security/fn:string(),$results/delay-types/NAS/fn:string(),$results/delay-types/late-aircraft/fn:string()
        ))
    ))

};

declare function aj:aiport-delays-json($results as item()) {
    json:oa((
        for $item in $results/item
        return json:o((
            "aiport",json:iv(($item/airport/carrier/fn:string())),
            "late",$item/late/fn:string(),
            "onTime",$item/on-time/fn:string(),
            "avgDelay",$item/avg-delay/avg-delay-dep/fn:string()
        ))
    ))
};

declare function aj:distance-delays-json($results as item()) {
    json:o((
        "arrivals",json:o((
            "distance-group",json:oa((
                for $item in $results/arrivals/item
                return json:iv(($item/distance/fn:string()))
            )),
            "avgDelays",json:oa((
                for $item in $results/arrivals/item
                return json:iv(($item/avg-delay/fn:string()))
            ))
        )),
        "departures",json:o((
            "distance-group",json:oa((
                for $item in $results/departures/item
                return json:iv(($item/distance/fn:string()))
            )),
            "avgDelays",json:oa((
                for $item in $results/departures/item
                return json:iv(($item/avg-delay/fn:string()))
            ))
        ))
    ))
};

declare function aj:timeb-delays-json($results as item()) {
    json:o((
        "arrivals",json:o((
            "interval",json:oa((
                for $item in $results/arrivals/item
                return json:iv(($item/interval/fn:string()))
            )),
            "count",json:oa((
                for $item in $results/arrivals/item
                return json:iv(($item/count/fn:string()))
            ))
        )),
        "departures",json:o((
            "interval",json:oa((
                for $item in $results/departures/item
                return json:iv(($item/interval/fn:string()))
            )),
            "count",json:oa((
                for $item in $results/departures/item
                return json:iv(($item/count/fn:string()))
            ))
        ))
    ))
};