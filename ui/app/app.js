var app = angular.module('flight', [ 'ngCookies','ui.router', 'ui.bootstrap', 'flight.menu'
    , 'flight.time', 'flight.entities', 'flight.auth', 'flight.dashboard','flight.common'
	,'underscore','angular-table'])

	.config(['$urlRouterProvider', '$locationProvider', function ($urlRouterProvider, $locationProvider) {

		$urlRouterProvider.otherwise('/dashboard');
		$locationProvider.html5Mode({
			enabled: true,
			requireBase: false
		});

	}]);
