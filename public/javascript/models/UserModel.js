var UserModel = Backbone.Model.extend({

    initialize: function(email, password) {
        login_request = {'action': 'login', 'data': {'email': email, 'password': password}};
        connection.send(JSON.stringify(login_request));
    }

});