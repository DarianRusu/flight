module namespace wj = 'http://marklogic.com/roxy/views/hourly-delays.json';

import module namespace json = "http://marklogic.com/roxy/simple-json-lib" at "/app/views/helpers/simple-json-lib.xqy";

declare function wj:delays-json($results as item()) {

    json:o((
        "arrivals",json:o((
            "weekday",json:oa((
                for $item in $results/arrivals/item
                return json:iv(($item/hour/fn:string()))
            )),
            "avgDelays",json:oa((
                for $item in $results/arrivals/item
                return json:iv(($item/avg-delay/fn:string()))
            ))
        )),
        "departures",json:o((
            "weekday",json:oa((
                for $item in $results/departures/item
                return json:iv(($item/hour/fn:string()))
            )),
            "avgDelays",json:oa((
                for $item in $results/departures/item
                return json:iv(($item/avg-delay/fn:string()))
            ))
        ))
    ))

};