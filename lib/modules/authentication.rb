module EventChat
  module Authentication

    # Just a mock at the moment. Real authentication will be added eventually
    def login(socket, data)
      # Fail by default
      response = {:action  => "login",
                  :status  => "fail",
                  :message => "There was a problem with your email or password"}

      # ===================
      # AUTHENTICATION HERE
      # ===================
      authentication = true
      
      if authentication
        # Our fake success
        response = {:action  => "login",
                    :status  => "success",
                    :message => "You have been logged in"}

      # Subscribe to the global channel      
      @global.subscribe do |msg|
        socket.send(msg)
      end
      
      # Create a new client
      user = Client.new(socket, data['email'])

      # Add the user to the socket pool
      @users[socket.signature] = user

      # Add the token and private_token to the response data
      response[:data] = {:private_token => user.private_token, :token => user.token}

      # Send the response on the next tick
      EM.next_tick { socket.send(response.to_json) }

      # Push a global notification to other users about the update
      connected_users(socket)
      else
        # When False...
      end
    end

    def connected_users(socket)
    end

  end
end