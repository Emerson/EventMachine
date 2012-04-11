module EventChat

  class Room

    attr_accessor :name, :sids

    def initialize(name)
      @name = name
      @sids = Hash.new
    end

  end


  module ChatRooms

    attr_accessor :rooms

    def initialize
      @rooms = {}
    end

    def add_chat_room(socket, data)
      if authorized?(socket)
        @rooms[socket.signature] = EventChat::Room.new(data['name'])
      end
    end

  end
end

