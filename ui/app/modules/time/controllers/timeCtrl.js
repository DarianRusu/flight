angular.module('flight.time').controller('timeCtrl', ['$scope', 'AuthSrv', 'MLRest', '$rootScope', '$sce', '$location', '$state',
    function($scope, AuthSrv, MLRest, sce, location, $rootScope, $state) {
        'use strict';
        $scope.hourlyDelays = {};
        $scope.tableData = [];

        $scope.getHourlyDelays = function() {
            return MLRest.callExtension('hourly-delays', { 'method' : 'GET'})
                .then(function(data){
                    $scope.hourlyDelays = {
                        labels : data.arrivals.weekday,
                        series : ['Arrivals', 'Departures'],
                        data : [
                            data.arrivals.avgDelays,
                            data.departures.avgDelays
                        ],
                        options: {
                            scaleShowVerticalLines: false,
                            barShowStroke : false
                        },
                        colours: ['Blue','Gray']

                    };
                    for (var i = 0; i < data.arrivals.avgDelays.length; i++) {
                        var aux = {
                            day : data.arrivals.weekday[i],
                            avgDepDelay: parseFloat(Math.round(data.departures.avgDelays[i] * 100) / 100).toFixed(2),
                            avgArrDelay: parseFloat(Math.round(data.arrivals.avgDelays[i] * 100) / 100).toFixed(2)
                        };
                        $scope.tableData.push(aux);
                    }
                    console.log($scope.tableData);
                });
        };

        $scope.getWeekdayMonthDelays = function() {
            return MLRest.callExtension('weekday-delays', { 'method' : 'GET'})
                .then(function(data){
                    $scope.weekDayMonthDelays = {
                        firstMonth : {
                            labels : data.firstMonth.arrivals.weekday,
                            series : ['Arrivals', 'Departures'],
                            data : [
                                data.firstMonth.arrivals.avgDelays,
                                data.firstMonth.departures.avgDelays
                            ],
                            options: {
                                scaleShowVerticalLines: false,
                                barShowStroke : false,
                                datasetFill : false,
                                scaleShowGridLines: false,
                                scaleShowHorizontalLines: false,
                                bezierCurve : false,
                                pointDot : true,
                                datasetStrokeWidth : 4,
                                showScale: false,
                                maintainAspectRatio: false
                            },
                            colours: ['Blue','Gray']
                        },
                        secondMonth : {
                            labels : data.secondMonth.arrivals.weekday,
                            series : ['Arrivals', 'Departures'],
                            data : [
                                data.secondMonth.arrivals.avgDelays,
                                data.secondMonth.departures.avgDelays
                            ],
                            options: {
                                scaleShowVerticalLines: false,
                                barShowStroke : false,
                                datasetFill : false,
                                scaleShowGridLines: false,
                                scaleShowHorizontalLines: false,
                                bezierCurve : false,
                                pointDot : true,
                                datasetStrokeWidth : 4,
                                showScale: false,
                                maintainAspectRatio: false
                            },
                            colours: ['Blue','Gray']
                        }

                    };
                });
        };
        $scope.getWeekdayMonthDelays();
        $scope.getHourlyDelays();
}]);