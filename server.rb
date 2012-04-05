require "rubygems"
require "eventmachine"
require "em-websocket"
require "pp"


require "./lib/connection_manager"



server_options = {:host => 'localhost', :port => 8080}

def close(ws)
  puts "Connection Terminated"
end


CM = ConnectionManager.new

EM.run do

  puts "Starting the Reactor..."
  puts "Socket: ws://#{server_options[:host]}:#{server_options[:port]}"

  EM::WebSocket.start(server_options) do |ws|

    ws.onopen { CM.add_socket(ws) }
    ws.onmessage { |msg| CM.process_message(ws, msg) }
    ws.onclose{ CM.remove_socket(ws) }

  end

end