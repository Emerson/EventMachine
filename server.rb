require "rubygems"
require "eventmachine"
require "em-websocket"


server_options = {:host => 'localhost', :port => 8080}


def open(ws)
  puts "Connection Established"
end

def close(ws)
  puts "Connection Terminated"
end

def process_message
  puts "Processing Message"
end

EM.run do

  puts "Starting the Reactor..."
  puts "Socket: ws://#{server_options[:host]}:#{server_options[:port]}"

  EM::WebSocket.start(server_options) do |ws|

    ws.onopen { open(ws) }
    ws.onmessage { |msg| process_message(ws, msg) }
    ws.onclose{ close(ws) }

  end

end