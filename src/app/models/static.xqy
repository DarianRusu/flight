xquery version "1.0-ml";

module namespace s = "http://marklogic.com/roxy/models/static";

declare function s:static-absolutes(){
    fn:doc("/statics/absolutes")/result
};
declare function s:static-carrier-delays(){
    fn:doc("/statics/carrier-delays")/results
};
declare function s:static-hourly(){
    fn:doc("/statics/hourly-delays")/results
};
declare function s:static-daily-month(){
    fn:doc("/statics/weekly-month-delays")/results
};
declare function s:static-distance-delay(){
    fn:doc("/statics/distance-delays")/results
};
declare function s:time-block-over-delays(){
    fn:doc("/statics/time-blocks-delays")/results
};
declare function s:aiport-delays(){
    fn:doc("/statics/aiport-delays")/results
};