angular.module('flight.entities').controller('entitiesCtrl', ['$scope', 'AuthSrv', 'MLRest', '$rootScope', '$sce', '$location', '$state',
    function($scope, AuthSrv, MLRest, sce, location, $rootScope, $state) {
        'use strict';
        $scope.carrierData = {};
        $scope.aiportData = [];
        $scope.config = {
            itemsPerPage: 20,
            fillLastPage: true
        };

        $scope.getCarrierData = function() {
            return MLRest.callExtension('carrier-delays', { 'method' : 'GET'})
                .then(function(data){
                    $scope.carrierData = data;
                });
        };
        $scope.getAirportData = function() {
            return MLRest.callExtension('airport-delays', { 'method' : 'GET'})
                .then(function(data){
                    for (var i = 0; i < data.length; i++) {
                        var aux = {
                            aiport: data[i].aiport,
                            avgDelay: parseFloat(data[i].avgDelay.toFixed(2)),
                            late: parseFloat(data[i].late.toFixed(2)),
                            onTime: parseFloat(data[i].onTime.toFixed(2))
                        };
                        $scope.aiportData.push(aux);
                    }
                    console.log($scope.aiportData);
                });
        };
        $scope.getCarrierData();
        $scope.getAirportData();
}]);