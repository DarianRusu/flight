angular.module('flight.dashboard', ['flight.auth','flight.common','chart.js']).config(['$stateProvider', function($stateProvider) {
    'use strict';

    $stateProvider.state({
        name: 'dashboard',
        url: '/dashboard',
        templateUrl: 'modules/dashboard/views/dashboard.html',
        controller: 'DashboardCtrl'
    });
}]);