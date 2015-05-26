'use strict';
describe("navbar directive", function() {
	var scope, template = '<navbar></navbar>', element, authSrvMock ;

	
	beforeEach(module('app.auth'));
	beforeEach(module('templates'));
	
	beforeEach(function() {
		authSrvMock = {
			login: function(username, password) {
				
			},
			logout: function() {
				
			}
		};
		module('app.components', function($provide) {
			$provide.value('AuthSrv', authSrvMock);
		});
	});

	describe("when a user is not authentified ", function() {
			beforeEach(function() {
				inject(function($compile, $rootScope) {
					scope = $rootScope;
					$rootScope.currentUser = {authenticated: false};
					var localScope = $rootScope.$new();
					element = $compile(template)(localScope);
				});
				scope.$digest();
			});
			it('should be in initial state', function() {
				expect( $( element ).find('form.ng-valid').length == 1); //login form is shown
				expect( $( element ).find('div.ng-hide.alert-danger').length == 1); //login error message not shown
				expect( $( element ).find('div.ng-hide.welcome').length == 1); //welcome message with username is not shown
			});
		}
	);
	
	describe("when a user has login error ", function() {
		beforeEach(function() {
			inject(function($compile, $rootScope) {
				scope = $rootScope;
				$rootScope.currentUser = {authenticated: false, loginError: true};
				var localScope = $rootScope.$new();
				element = $compile(template)(localScope);
			});
			scope.$digest();
		});
		it('should show login error', function() {
			expect( $( element ).find('div.ng-valid.alert-danger').length == 1); //login error message is shown
			expect( $( element ).find('form.ng-valid').length == 1); //login form is shown
			expect( $( element ).find('div.ng-hide.welcome').length == 1); //welcome message with username is not shown
		});
	});
	
	describe("when a user is authenticated", function() {
		beforeEach(function() {
			inject(function($compile, $rootScope) {
				scope = $rootScope;
				$rootScope.currentUser = {authenticated: true, loginError: false, username: "SUPERUSER"};
				var localScope = $rootScope.$new();
				element = $compile(template)(localScope);
			});
			scope.$digest();
		});
		it('should great the user', function() {
			expect( $( element ).find('form.ng-hide').length == 1); //login form is not shown
			expect( $( element ).find('div.ng-hide.alert-danger').length == 1); //login error message is not shown
			expect( $( element ).find('div.ng-valid.welcome').length == 1); //welcome message with username is shown
			expect(element.html()).toContain('SUPERUSER');
		});
	});
});
