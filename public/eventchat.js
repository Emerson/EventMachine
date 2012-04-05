var ws = false;


$(document).ready(function() {

	$('#connect').click(function(e) {
		e.preventDefault();
		var username = $('#username').val();
		ws = new WebSocket('ws://localhost:8080/?username='+username);
		ws.onmessage = function(msg) {
		    console.log(msg);
		}
	});

	$('#send').click(function(e) {
		e.preventDefault();
		ws.send($('#message').val());
	});

});