var UserModel = Backbone.Model.extend({

	initialize: function(email, password) {
		login_request = {'action': 'login', 'data': {'email': email, 'password': password}};
		ws.send(JSON.stringify(login_request));
	}

});