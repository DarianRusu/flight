angular.module('flight.menu',[]).directive('menu', function () {
  'use strict';

  return {
    restrict: 'E',
    templateUrl: '/components/menu/menu.html',
    replace: true,
    controller: ['_', '$scope','$state','AuthSrv',
      function (_, $scope, $state, AuthSrv) {

        $scope.activeOnStates = function(states) {
          if (_.some(states, $state.includes)) {
            return "active";
          }
        };
        $scope.login = function(user, password){
          AuthSrv.login(user, password);
        };

        $scope.logout = function(){
          AuthSrv.logout();
        };

      }]
  };
});
