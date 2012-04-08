var LobbyView = Backbone.View.extend({

	el: '#view',

	render: function(view) {
		var lobbyLayoutHtml = Mustache.to_html($('#lobbyLayoutTemplate').html());
		$(this.el).html(lobbyLayoutHtml);
		$('body').data('current-view', 'lobbyLayout');
	},

	update_users: function(type, json) {
		var onlineUserHtml = $('#onlineUserTemplate').html();
		$('.online-users').empty();
		$.each(json.data.users, function(id, user) {
			console.log(id, user);
			$('.online-users').append(Mustache.to_html(onlineUserHtml, user));
		});
		
	}

});