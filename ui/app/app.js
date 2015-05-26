var app = angular.module('flight', [ 'ngCookies','ui.router', 'ui.bootstrap', 'flight.menu', 'flight.predict', 'flight.auth', 'flight.dashboard','flight.common'
	,'underscore'])

	.config(['$urlRouterProvider', '$locationProvider', function ($urlRouterProvider, $locationProvider) {

		$urlRouterProvider.otherwise('/');
		$locationProvider.html5Mode({
			enabled: true,
			requireBase: false
		});

	}]);
