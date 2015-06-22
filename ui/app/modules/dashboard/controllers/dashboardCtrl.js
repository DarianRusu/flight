angular.module('flight.dashboard').controller('DashboardCtrl', ['$scope', 'AuthSrv', 'MLRest', '$rootScope', '$sce', '$location', '$state',
    function($scope, AuthSrv, MLRest, sce, location, $rootScope, $state) {
        'use strict';
        $scope.absolutes = {};
        $scope.arrivalsDelayData = {};
        $scope.departuresDelayData = {};
        $scope.delayTypes = {
            data: []
        };
        $scope.hourlyDelays = {};
        $scope.carrierData = {};

        $scope.getAbsolutes = function() {
            return MLRest.callExtension('absolutes', { 'method' : 'GET'})
                .then(function(data){
                    $scope.absolutes = data;
                    $scope.arrivalsDelayData.labels = ["Late %","On time %"];
                    $scope.departuresDelayData.labels = ["Late %","On time %"];
                    $scope.delayTypes.labels = ["carrier","weather","security","NAS","late aircraft"];
                    $scope.arrivalsDelayData.data = [
                        parseFloat(Math.round(data.lateArrivalsPer * 100) / 100).toFixed(2),
                        parseFloat(Math.round(data.onTimeArrivalsPer * 100) / 100).toFixed(2)];
                    $scope.departuresDelayData.data = [
                        parseFloat(Math.round(data.lateDeparturePer * 100) / 100).toFixed(2),
                        parseFloat(Math.round(data.onTimeDeparturePer * 100) / 100).toFixed(2)];
                    for (var i = 0; i < data.delayTypes.length; i++) {
                        $scope.delayTypes.data.push( parseFloat(Math.round(data.delayTypes[i] * 100) / 100).toFixed(2));
                    }
                });
        };
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
                                datasetFill : false
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
                                datasetFill : false
                            },
                            colours: ['Blue','Gray']
                        }

                    };
                    console.log($scope.weekDayMonthDelays);
                });
        };
        $scope.getCarrierData = function() {
            return MLRest.callExtension('carrier-delays', { 'method' : 'GET'})
                .then(function(data){
                    $scope.carrierData = data;
                });
        };
        $scope.onClick = function (points, evt) {
            //console.log(points, evt);
        };
        $scope.getAbsolutes();
        $scope.getHourlyDelays();
        $scope.getCarrierData();
        $scope.getWeekdayMonthDelays();
}]);