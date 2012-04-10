var ConnectionModel = Backbone.Model.extend({

	open: false,
	ws: false,
	reconnect: false,

    initialize: function() {
    	
    	var that = this;

		this.ws = new ReconnectingWebSocket( this.websocket_url() );

	    this.ws.onmessage = function(msg) {
	    	console.log(msg, 'raw onmessage');
	    	try {
	    		msg = JSON.parse(msg.data);
	    		console.log(msg, 'parsed message');
	    		$('body').trigger(msg['action'], msg);
	    	}
	    	catch(err) {
	    		console.log('JSON string error', err);
	    	}
	    	
	    };

	    this.ws.onclose = function(msg) {
	    	console.log(msg, 'onclose');
	    	that.open = false;
	    	console.log('connection_lost');
	    	$('body').trigger('connection_lost', msg);
	    };

	    this.ws.onopen = function(msg) {
	    	console.log(msg, 'onopen');
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
    },

    websocket_url: function() {
    	return "ws://" + location.hostname +":8080/";
    }

});