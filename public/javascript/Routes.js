var Routes = Backbone.Router.extend({

	self: {},

	initialize: function(app) {
		self = app;
	},

	routes: {
		"login":          "login",
		"lobby":          "lobby",
		"private/:room":  "room",
		"reconnect":      "reconnect"
	},

	render: function(view) {
		// if(this.currentView) {
		// 	this.currentView.remove();
		// }

		console.log(view, 'rendering');
		view.render();

		this.currentView = view;

		return this;
	},

	login: function() {
		console.log('/login');
		this.render(self.LoginView);
	},

	lobby: function() {
		console.log('/lobby');
		console.log(self.LobbyView, 'LobbyView');
		this.render(self.LobbyView);
	},

	reconnect: function() {
		console.log('/reconnect');
		this.render(self.ReconnectView);
	},

	private: function(room) {
		console.log('/private/:room');
		this.render(self.ReconnectView);
	}

});