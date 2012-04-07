var LoginView = Backbone.View.extend({

	el: '#view',

	events: {
		'click .login': 'login'
	},

	render: function() {
		var loginLayoutHtml = Mustache.to_html($('#loginLayoutTemplate').html());
		$(this.el).html(loginLayoutHtml);
		$('body').data('current-view', 'loginLayout');
		this.delegateEvents();
	},

	login: function(e) {
		e.preventDefault();
		var user = new UserModel( $('#login_email').val(), $('#login_password').val() );
		if(user) {
			current_user = user;
			$('body').trigger('user_authenticated', user);
		}else{
			alert('That email and password are incorrect');
		}
	}

});