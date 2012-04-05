var ReconnectLayout = Backbone.View.extend({

	el: '#view',

	events: {
		'click #reconnect': 'reconnect'
	},

	render: function() {
		var reconnectLayoutHtml = Mustache.to_html($('#reconnectLayoutTemplate').html());
		$(this.el).html(reconnectLayoutHtml);
	},

	reconnect: function(e) {
		if(new ConnectionModel().connect()) {

		}else{
			
		}
		e.preventDefault();
	}

});