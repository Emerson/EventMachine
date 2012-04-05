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
    puts "Adding socket to pool: #{socket.signature}"
    @global.subscribe do |msg|
      socket.send(msg)
    end
    @global.push("#{socket.signature} connected")      
    @sockets[socket.signature] = socket
    socket.send('connected');
  end

  def remove_socket(socket)
    puts "Removing socket from pool: #{socket.signature}"
    @sockets.delete(socket.signature)
    @global.push("#{socket.signature} disconnected")
  end

  def process_message(socket, msg)
    if msg
      msg = JSON(msg)
      self.send(msg['action'], msg['data'], socket) if self.respond_to?(msg['action'])
    end
    puts msg
  end

  def login(data, socket)
    pp data
  end

end