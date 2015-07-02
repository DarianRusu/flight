angular.module('flight.distance', ['flight.auth','flight.common']).config(['$stateProvider', function($stateProvider) {
    'use strict';

    $stateProvider.state({
        name: 'distance',
        url: '/distance',
        templateUrl: 'modules/distance/views/distance.html',
        controller: 'distanceCtrl'
    });
}]);