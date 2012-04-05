class ConnectionManager

  attr_accessor :rooms, :sockets, :global

  def initialize
    @rooms = {}
    @sockets = {}
    @global = EM::Channel.new
  end

  def add_room(room)
    @rooms[room.token] = room
  end

  def remove_room(room)
    @rooms.delete(room.token)
  end

  def add_socket(socket)
    puts "Adding socket to pool"
    token = socket.request['query']['auth']
    @sockets[token] = socket
  end

  def remove_socket(socket)
    puts "Removing socket from pool"
    token = socket.request['query']['auth']
    @sockets.delete(token)
  end

  def process_message(socket, msg)
    puts msg
    @sockets.each do |key, item|
      pp "auth: "+item.request['query']['auth']
    end
  end
end