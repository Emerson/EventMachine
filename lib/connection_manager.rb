class ConnectionManager

  include EventChat::Authentication

  attr_accessor :sockets, :global, :users

  def initialize
    # All connected sockets
    @sockets = {}

    # Authenticated users
    @users = {}

    # Authenticated users channel
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
    EM.next_tick { authenticated_users(socket) }
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
        self.send(msg['action'], socket, msg['data']) if self.respond_to?(msg['action'])
      end
    
  end

  def process_global_chat_message(data, socket)
    pp data
  end

end