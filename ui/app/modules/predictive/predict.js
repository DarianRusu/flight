angular.module('flight.predict', ['flight.auth','flight.common']).config(['$stateProvider', function($stateProvider) {
    'use strict';

    $stateProvider.state({
        name: 'predict',
        url: '/predict',
        templateUrl: 'modules/predictive/views/predict.html',
        controller: 'PredictCtrl'
    });
}]);