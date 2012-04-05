var LoginLayout = Backbone.View.extend({

	el: '#view',

	events: {
		'click #login': 'login'
	},

	render: function() {
		var loginLayoutHtml = Mustache.to_html($('#loginLayoutTemplate').html());
		$(this.el).html(loginLayoutHtml);
		this.delegateEvents();
	},

	login: function(e) {
		e.preventDefault();
		new UserModel( $('#login_email').val(), $('#login_password').val() );
	}

});