/**
 * @ngdoc service
 * @name AuthSrv
 * @description Exposes services required in the authorization process.
 */
angular.module('flight.auth').factory('AuthSrv', ['$rootScope', '$http',
	function($rootScope, $http) {
		'use strict';
		
		$rootScope.currentUser = {
			authenticated : false
		};
		
	    $http.get('/user/status', {}).then(function(response){
	    	 $rootScope.currentUser.authenticated = response.data.authenticated;
	    	 $rootScope.currentUser.loginError = false;
	    	 $rootScope.currentUser.username = response.data.username; 
	    });

	    return {
			/** Authenticate user */
			login: function(username, password) {
				$rootScope.currentUser.authenticating = true;
				 $http.get(
				     '/user/login',
				     {
				         params: {
				             'username': username,
				             'password': password
				          }
				      }).success(function(data) {
						 $rootScope.currentUser.authenticating = false;
				    	  $rootScope.currentUser.authenticated = data.authenticated;
				    	  if ($rootScope.currentUser.authenticated === true) {
				    		  $rootScope.currentUser.loginError = false;
				    		  $rootScope.currentUser.username = data.username; 
				    	  } else {
				    		  $rootScope.currentUser.loginError = true;
				    	  }
				      }).error(function() {
						 $rootScope.currentUser.authenticating = false;
				    	  $rootScope.currentUser.loginError = true;
				    	  $rootScope.currentUser.authenticated = false;
				    	  
				      });
			},
			
			/** Logout user*/
			logout: function() {
				$http.get(
				     '/user/logout', {})
				     .then(function() { 
				    	 $rootScope.currentUser = {
				    	     authenticated : false,
				    	     loginError : false,
				    	     username : ''
				    	 };
				      });
			}

		};
	}
]);
