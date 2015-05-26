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