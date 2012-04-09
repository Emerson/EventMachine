module EventChat
  module GlobalChat

    def process_global_chat_message(socket, data)
      if authorized?(socket)
      	user = user_for_socket(socket)
        response = {:action => 'global_chat_message', :data => {:message => data['message'],
        	 												    :user => {:email => user.email},
        	 												    :timestamp => Time.now.to_i}}.to_json
        @global.push(response)
      end
    end

  end
end