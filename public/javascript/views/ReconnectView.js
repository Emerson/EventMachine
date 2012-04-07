var ReconnectView = Backbone.View.extend({

	el: '#view',

	render: function() {
		var reconnectLayoutHtml = Mustache.to_html($('#reconnectLayoutTemplate').html());
		$(this.el).html(reconnectLayoutHtml);
		$('body').data('current-view', 'reconnectLayout');
	}

});