module namespace wj = 'http://marklogic.com/roxy/views/weekday-delays.json';

import module namespace json = "http://marklogic.com/roxy/simple-json-lib" at "/app/views/helpers/simple-json-lib.xqy";

declare function wj:delays-json($results as item()) {

    json:o((
        "firstMonth",json:o((
            "arrivals",json:o((
                "weekday",json:oa((
                    for $item in $results/first-month/arrivals/weekday
                    return json:iv(($item/fn:string()))
                )),
                "avgDelays",json:oa((
                    for $item in $results/first-month/arrivals/avg-delay
                    return json:iv(($item/fn:string()))
                ))
            )),
            "departures",json:o((
                "weekday",json:oa((
                    for $item in $results/first-month/departures/weekday
                    return json:iv(($item/fn:string()))
                )),
                "avgDelays",json:oa((
                    for $item in $results/first-month/departures/avg-delay
                    return json:iv(($item/fn:string()))
                ))
            ))
        )),

        "secondMonth",json:o((
            "arrivals",json:o((
                "weekday",json:oa((
                    for $item in $results/second-month/arrivals/weekday
                    return json:iv(($item/fn:string()))
                )),
                "avgDelays",json:oa((
                    for $item in $results/second-month/arrivals/avg-delay
                    return json:iv(($item/fn:string()))
                ))
            )),
            "departures",json:o((
                "weekday",json:oa((
                    for $item in $results/second-month/departures/weekday
                    return json:iv(($item/fn:string()))
                )),
                "avgDelays",json:oa((
                    for $item in $results/second-month/departures/avg-delay
                    return json:iv(($item/fn:string()))
                ))
            ))
        ))
    ))



};