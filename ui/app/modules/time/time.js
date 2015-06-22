angular.module('flight.time', ['flight.auth','flight.common']).config(['$stateProvider', function($stateProvider) {
    'use strict';

    $stateProvider.state({
        name: 'time',
        url: '/time',
        templateUrl: 'modules/time/views/time.html',
        controller: 'timeCtrl'
    });
}]);