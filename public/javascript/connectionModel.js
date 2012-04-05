var ConnectionModel = Backbone.Model.extend({

    initialize: function() {
        ws = new WebSocket('ws://0.0.0.0:8000');
    }

});