/* global describe, beforeEach, module, it, expect, inject */

describe('tests for AuthSrv service', function () {
  'use strict';

  var AuthSrv = null, $httpBackend, $rootScopeTest;

  beforeEach(module('app.auth'));

  beforeEach(inject(function ($injector) {
    $httpBackend = $injector.get('$httpBackend');
    $rootScopeTest = $injector.get('$rootScope').$new();
    AuthSrv = $injector.get('AuthSrv',  $rootScopeTest, $httpBackend);
  }));
    
  it('should test currentUser.authenticated without having a session before calling any function', function() {
	    $httpBackend
	      .expectGET('/user/status')
	      .respond({data : {authenticated: false}});
	    
	   	expect($rootScopeTest.currentUser.authenticated == false);
	   
	    $httpBackend.flush();
  });

  it('should test currentUser.authenticated when having a session before calling any function', function() {
	    $httpBackend
	      .expectGET('/user/status')
	      .respond({data : {authenticated: true}});
	    
	   	expect($rootScopeTest.currentUser.authenticated == true);
	   
	    $httpBackend.flush();
  });  
  
  it('should test login with good credentials', function() {
    $httpBackend
      .expectGET('/user/status')
      .respond({data : {authenticated: false}});
    
    $httpBackend
    	.expectGET('/user/login?password=pass&username=user')
    	.respond({data : {authenticated: true, username: "user"}});

    AuthSrv.login('user', 'pass');
   	expect($rootScopeTest.currentUser.authenticated == true);
   	expect($rootScopeTest.currentUser.loginError == false);
   	expect($rootScopeTest.currentUser.username === 'user');
   
    $httpBackend.flush();
  });
  
  it('should test  login with bad credentials', function() {
	    $httpBackend
	      .expectGET('/user/status')
	      .respond({data : {authenticated: false}});
	    
	    $httpBackend
	    	.expectGET('/user/login?password=pass&username=user')
	    	.respond({data : {authenticated: false}});

	    AuthSrv.login('user', 'pass');
	   	expect($rootScopeTest.currentUser.authenticated == false);
	   	expect($rootScopeTest.currentUser.loginError == true);
	   	expect($rootScopeTest.currentUser.username === '');
	   
	    $httpBackend.flush();
  });
  
  it('should test login with unauthorized error', function() {
	    $httpBackend
	      .expectGET('/user/status')
	      .respond({data : {authenticated: false}});
	    
	    $httpBackend
	    	.expectGET('/user/login?password=pass&username=user')
	    	.respond(401, 'Unauthorized');

	    AuthSrv.login('user', 'pass');
	   	expect($rootScopeTest.currentUser.authenticated == false);
	   	expect($rootScopeTest.currentUser.loginError == true);
	   
	    $httpBackend.flush();
  });
  
  it('should test logout', function() {
	    $httpBackend
	      .expectGET('/user/status')
	      .respond({data : {authenticated: false}});
	    
	    $httpBackend
	    	.expectGET('/user/logout')
	    	.respond(200);

	    AuthSrv.logout();
	   	expect($rootScopeTest.currentUser.authenticated == false);
	   	expect($rootScopeTest.currentUser.loginError == false);
	   
	    $httpBackend.flush();
  });
});
