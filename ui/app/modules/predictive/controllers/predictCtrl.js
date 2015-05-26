angular.module('flight.predict').controller('PredictCtrl', ['$scope', 'AuthSrv', 'MLRest', '$rootScope', '$sce', '$location', '$state',
    function($scope, AuthSrv, MLRest, sce, location, $rootScope, $state) {
        'use strict';
        $scope.text = "predict";

        $scope.init = function(){
            console.log("predict");
        };
        $scope.init();
}]);