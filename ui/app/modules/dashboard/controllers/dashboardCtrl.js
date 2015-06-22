angular.module('flight.dashboard').controller('DashboardCtrl', ['$scope', 'AuthSrv', 'MLRest', '$rootScope', '$sce', '$location', '$state',
    function($scope, AuthSrv, MLRest, sce, location, $rootScope, $state) {
        'use strict';
        $scope.absolutes = {};
        $scope.arrivalsDelayData = {};
        $scope.departuresDelayData = {};
        $scope.delayTypes = {
            data: []
        };
        $scope.tableTypes = [];
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
                    for (var i = 0; i < data.delayTypes.length; i++) {
                        var aux = {
                            title : $scope.delayTypes.labels[i],
                            value : $scope.delayTypes.data[i]
                        };
                        $scope.tableTypes.push(aux);
                    }
                });
        };
        $scope.onClick = function (points, evt) {
            //console.log(points, evt);
        };
        $scope.getAbsolutes();

}]);