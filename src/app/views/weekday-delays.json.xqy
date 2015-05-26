module namespace wj = 'http://marklogic.com/roxy/views/weekday-delays.json';

import module namespace json = "http://marklogic.com/roxy/simple-json-lib" at "/app/views/helpers/simple-json-lib.xqy";

declare function wj:delays-json($results as item()) {

    json:o((
        "arrivals",json:o((
            "weekday",json:oa((
                for $item in $results/arrivals
                return $item/weekday/fn:string()
            )),
            "avgDelays",json:oa((
                for $item in $results/arrivals
                return $item/avg-delay/fn:string()
            ))
        )),
        "departures",json:o((
            "weekday",json:oa((
                for $item in $results/departures
                return $item/weekday/fn:string()
            )),
            "avgDelays",json:oa((
                for $item in $results/departures
                return $item/avg-delay/fn:string()
            ))
        ))
    ))

};