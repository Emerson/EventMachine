var connection,
	current_user,
	application,
	base_url;


// Create our Application
var App = (function($) {

	var self = {};

	// The Views
	self.LoginView     = new LoginView();
	self.ReconnectView = new ReconnectView();
	self.LobbyView     = new LobbyView();

	self.start = function() {
		base_url = window.location.href;
     	connection = new ConnectionModel();

     	// Setup and start the router
   		self.Router = new Routes(self);
   		Backbone.history.start({pushState: true, root: window.location.pathname});
		
		// Visit the login action
   		self.Router.navigate('login');

   		// Bind our websocket events to routes
		self.bind_events(self.Router);
	};

	self.bind_events = function(router) {
		// Main Routes
		$('body').on('connection_lost', function() { self.Router.navigate("reconnect", {trigger: true}); });
		$('body').on('connection_reestablished', function() { self.Router.navigate("login", {trigger: true}); });
		$('body').on('user_authenticated', function(e, msg) { self.Router.navigate("lobby", {trigger: true}); });

		// Specific WebSocket Events
		$('body').on('login', function(e, msg) { self.LobbyView.set_user_credentials(e, msg); });
		$('body').on('connected_users', function(e, msg) { self.LobbyView.update_users(e, msg) });
	}

	return self;

});



$(document).ready(function() {

	application = new App(jQuery);
	application.start();

});