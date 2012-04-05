var ws = false;


$(document).ready(function() {

	$('#connect').click(function(e) {
		e.preventDefault();
		var path = $('#token').val();
		ws = new WebSocket('ws://localhost:8080/?auth='+path);
		ws.onmessage = function(msg) {
		    console.log(msg);
		}
	});

	$('#send').click(function(e) {
		e.preventDefault();
		ws.send($('#message').val());
	});

});