var ConnectionModel = Backbone.Model.extend({

	open: false,
	ws: false,
	reconnect: false,

    initialize: function() {
    	
    	var that = this;

		this.ws = new ReconnectingWebSocket('ws://0.0.0.0:8000');

	    this.ws.onmessage = function(msg) {
	    	try {
	    		msg = JSON.parse(msg.data);
	    		$('body').trigger(msg['action'], msg);
	    		console.log(msg, 'JSON onmessage');
	    	}
	    	catch(err) {
	    		console.log('JSON string error', err);
	    	}
	    	
	    };

	    this.ws.onclose = function(msg) {
	    	that.open = false;
	    	console.log('connection_lost');
	    	$('body').trigger('connection_lost', msg);
	    };

	    this.ws.onopen = function(msg) {
	    	if(that.reconnect) {
	    		console.log('Reconnected');
	    		$('body').trigger('connection_reestablished');
	    	}
	    	that.reconnect = true;
	    	that.open = true;
	    };

    },

    send: function(msg) {
    	console.log('Sending:', msg);
    	if(this.open) {
    		this.ws.send(msg);
    	};
    }

});