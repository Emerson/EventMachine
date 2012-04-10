var LobbyView = Backbone.View.extend({

	el: '#view',

	events: {
		"click #globalChatSubmit"          : "send_global_chat_message"
	},

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
	},

	send_global_chat_message: function(e) {
		e.preventDefault();
		var message = $('#globalChatMessage').val();
		if(message != '') {
			var response = {action: 'process_global_chat_message', data: {'message': message, user: current_user}};
			connection.send(JSON.stringify(response));
		}
		$('#globalChatMessage').val('');
	},

	global_chat_message: function(type, json) {
		$('.global-chat-window').append("<p><strong>"+json.data.user.email+"</strong>: "+json.data.message+"</p>")
	},

	set_user_credentials: function(type, json) {
		console.log(type, 'set_user_credentials');
		console.log(json, 'set_user_credentials');
		if(current_user) {

			// current_user.set('private_token', )
		}
	}

});