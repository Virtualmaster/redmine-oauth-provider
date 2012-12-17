ActionController::Routing::Routes.draw do |map|
  map.resources :oauth_clients

  map.test_request '/oauth/test_request', :controller => 'oauth', :action => 'test_request'
  map.token '/oauth/token', :controller => 'oauth', :action => 'token'
  map.access_token '/oauth/access_token', :controller => 'oauth', :action => 'access_token'
  map.request_token '/oauth/request_token', :controller => 'oauth', :action => 'request_token'
  map.authorize '/oauth/authorize', :controller => 'oauth', :action => 'authorize'
  map.revoke '/oauth/revoke', :controller => 'oauth', :action => 'revoke'
  map.oauth '/oauth', :controller => 'oauth', :action => 'index'
end
