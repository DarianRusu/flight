xquery version "1.0-ml";

module namespace s = "http://marklogic.com/roxy/models/create-static-files";
import module namespace a = "http://marklogic.com/roxy/models/absolutes-lib" at "/app/models/absolutes-lib.xqy";
import module namespace c = "http://marklogic.com/roxy/models/carrier-delays-lib" at "/app/models/carrier-delays-lib.xqy";
import module namespace w = "http://marklogic.com/roxy/models/hourly-delays-lib" at "/app/models/hourly-delays-lib.xqy";
import module namespace ww = "http://marklogic.com/roxy/models/weekday-delays-lib" at "/app/models/weekday-delays-lib.xqy";

declare function s:static-absolutes-file(){
    let $results := a:absolutes()
    return
        xdmp:document-insert("/statics/absolutes",$results)
};
declare function s:static-carrier-delays(){
    let $results := c:get-carrier-delays()
    return
        xdmp:document-insert("/statics/carrier-delays",$results)
};
declare function s:static-hourly(){
    let $results := w:get-hourly-delays()
    return
        xdmp:document-insert("/statics/hourly-delays",$results)
};
declare function s:static-daily-month(){
    let $results := ww:get-weekday-month-delays()
    return
        xdmp:document-insert("/statics/weekly-month-delays",$results)
};
declare function s:static-distance-delay(){
    let $results := a:distance-over-delays()
    return
        xdmp:document-insert("/statics/distance-delays",$results)
};
declare function s:time-block-over-delays(){
    let $results := a:time-block-over-delays()
    return
        xdmp:document-insert("/statics/time-blocks-delays",$results)
};
declare function s:create-files(){
    s:static-absolutes-file(),s:static-carrier-delays(),s:static-hourly(),s:static-daily-month(),s:static-distance-delay(),s:time-block-over-delays(),s:aiport-delays()
};
declare function s:aiport-delays(){
    let $results := a:aiport-delays()
    return
        xdmp:document-insert("/statics/aiport-delays",$results)
};