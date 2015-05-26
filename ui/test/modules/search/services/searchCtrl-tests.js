'use strict';

describe('SearchCtrl', function() {
	var scope, rootScopeTest, $controllerConstructor, mlRest, q;
	
	///------- NOT WORKING ---------- ///
	/*
 	beforeEach(module('ui.router'));
	beforeEach(module('app.auth'));
	beforeEach(module('app.search'));
	beforeEach(module('app.common'));
	
	beforeEach(inject(function ($rootScope, $controller, $q) {
		 scope = $rootScope.$new();
		 rootScopeTest =  $rootScope.$new();
		 mlRest = sinon.stub({callExtension: function(extensionName, settings) {}});
		 q = $q;
		 $controllerConstructor = $controller;
	}));
	
	it('should set at load the searchResults on scope to the result of mlRest.callExtenstion ', function(){
		 var d = q.defer();
		 var searchResults = {results: [], total: 0};
		 d.resolve(searchResults);
		 mlRest.callExtension.returns(d.promise);
		 
		 var ctrl = $controllerConstructor('SearchCtrl', 
			{'$scope':scope, 'AuthSrv': {}, 'MLRest': mlRest, '$rootScope': rootScopeTest});
		 
		 expect(scope.model.results.length == 0);
		 expect(scope.model.total == 0);
		 expect(scope.model.facets.length == 2); //hard-coded - TODO changed
	});
	
	it('should set at search the searchResults on scope to the result of mlRest.callExtenstion ', function(){
		 var d0 = q.defer(), d1 = q.defer();
		 var searchResults0 = {results: [], total: 0} , searchResults1 = {results: [{'a':'b'}, {'c':'d'}], total:100};
		 d0.resolve(searchResults0); d1.resolve(searchResults1);
		 mlRest.callExtension.onCall(0).returns(d0.promise);
		 mlRest.callExtension.onCall(1).returns(d1.promise);
		 
		 var ctrl = $controllerConstructor('SearchCtrl', 
			{'$scope':scope, 'AuthSrv': {}, 'MLRest': mlRest, '$rootScope': rootScopeTest});
		 
		 expect(scope.model.results.length == 2);
		 expect(scope.model.total == 100);
		 expect(scope.model.facets.length == 2); //hard-coded - TODO changed
	}); */
	
});