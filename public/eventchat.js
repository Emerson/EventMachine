// Create our Application
var App = (function($) {

	var self = {};

	self.start = function() {
		new LoginLayout().render();
	};


	return self;

});





$(document).ready(function() {

	new App(jQuery).start();

	ws.onmessage = function(msg) {
		console.log(msg, msg.data);
	}

	// $('#connect').click(function(e) {
	// 	e.preventDefault();
	// 	var username = $('#username').val();
	// 	ws = new WebSocket('ws://localhost:8080/?username='+username);
	// 	ws.onmessage = function(msg) {
	// 	    console.log(msg);
	// 	}
	// });

	// $('#send').click(function(e) {
	// 	e.preventDefault();
	// 	ws.send($('#message').val());
	// });

});