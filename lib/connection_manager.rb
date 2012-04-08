class ConnectionManager

  attr_accessor :rooms, :sockets, :global, :users

  def initialize
    @rooms = {}
    @sockets = {}

    # Holds our authenticated users
    @users = {}

    # A channel for all authenticated users
    @global = EM::Channel.new
  end

  def add_socket(socket)
    puts "Adding Socket"
    response = {:action => "add_socket", :message => "Adding #{socket.signature} to pool"}.to_json
    @sockets[socket.signature] = socket
    socket.send(response);
  end

  def remove_socket(socket)
    puts "Removing Socket"
    response = {:action => "remove_socket", :message => "#{socket.signature} disconnected"}.to_json
    @sockets.delete(socket.signature)
    @users.delete(socket.signature)
    @global.push(response)
    EM.next_tick { connected_users(socket) }
  end

  def process_message(socket, msg)
    pp msg
    
      if msg
        begin
          puts "unparsed message: #{msg.inspect}"
          msg = JSON(msg)
        rescue Exception => e
          puts "Error Parsing: #{e.inspect}"
        end
        puts "parsed message: #{msg.inspect}"
        self.send(msg['action'], msg['data'], socket) if self.respond_to?(msg['action'])
      end
    
  end

  def login(data, socket)
    response = {:action => "login", :status => "fail", :message => "There was a problem with your email or password"}
    # TODO - Add real authentication

    @global.subscribe do |msg|
      socket.send(msg)
    end
    response = {:action => "login", :status => "success", :message => "You have been logged in"}
    user = Client.new(data['email'], socket)
    @users[socket.signature] = user
    connected_users(socket)
    socket.send(response.to_json)
  end

  def connected_users(socket)
    response = {:action => "connected_users", :status => "success"}
    response[:data] = {:online_users => @users.count, :users => generate_online_users_response()}
    @global.push(response.to_json)
  end

  def generate_online_users_response
    data = Hash.new
    @users.each do |index, user|
      data[user.token] = {:email => user.email, :id => user.token}
    end
    data
  end

end