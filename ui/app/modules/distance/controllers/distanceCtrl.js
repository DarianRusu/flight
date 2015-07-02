angular.module('flight.distance').controller('distanceCtrl', ['$scope', 'AuthSrv', 'MLRest', '$rootScope', '$sce', '$location', '$state',
    function($scope, AuthSrv, MLRest, sce, location, $rootScope, $state) {
        'use strict';
        $scope.distanceGroupsDelays = {};
        $scope.tableData = [];


        $scope.getDistanceGroupDelays = function() {
            return MLRest.callExtension('distance-delays', { 'method' : 'GET'})
                .then(function(data){

                    $scope.distanceGroupsDelays = {
                        labels : data.arrivals.distanceGroup,
                        series : ['Arrivals', 'Departures'],
                        data : [
                            data.arrivals.avgDelays,
                            data.departures.avgDelays
                        ],
                        options: {
                            scaleShowVerticalLines: false,
                            barShowStroke : false
                        },
                        colours: ['Blue','Red']

                    };
                    for (var i = 0; i < data.arrivals.avgDelays.length; i++) {
                        var aux = {
                            day : data.arrivals.distanceGroup[i],
                            avgDepDelay: parseFloat(Math.round(data.departures.avgDelays[i] * 100) / 100).toFixed(2),
                            avgArrDelay: parseFloat(Math.round(data.arrivals.avgDelays[i] * 100) / 100).toFixed(2)
                        };
                        $scope.tableData.push(aux);
                    }
                    console.log($scope.tableData);
                });
        };

        $scope.getDistanceGroupDelays();
}]);