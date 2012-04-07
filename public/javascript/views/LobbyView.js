var LobbyView = Backbone.View.extend({

	el: '#view',

	render: function(view) {
		var lobbyLayoutHtml = Mustache.to_html($('#lobbyLayoutTemplate').html());
		$(this.el).html(lobbyLayoutHtml);
		$('body').data('current-view', 'lobbyLayout');
	},

});