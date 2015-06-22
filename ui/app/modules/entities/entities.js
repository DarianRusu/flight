angular.module('flight.entities', ['flight.auth','flight.common']).config(['$stateProvider', function($stateProvider) {
    'use strict';

    $stateProvider.state({
        name: 'entities',
        url: '/entities',
        templateUrl: 'modules/entities/views/entities.html',
        controller: 'entitiesCtrl'
    });
}]);