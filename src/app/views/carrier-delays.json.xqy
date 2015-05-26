module namespace cj = 'http://marklogic.com/roxy/views/carrier-delays.json';

import module namespace json = "http://marklogic.com/roxy/simple-json-lib" at "/app/views/helpers/simple-json-lib.xqy";

declare function cj:delays-json($results as item()) {
    json:oa((
        for $item in $results/item
            return json:o((
                    "carrier",json:iv(($item/carrier/fn:string())),
                    "avgArrDelay",json:iv(($item/avg-delay-arr/fn:string())),
                    "avgDepDelay",json:iv(($item/avg-delay-dep/fn:string()))
                    ))
            ))

};