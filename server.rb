require "rubygems"
require "sinatra/base"
require "eventmachine"
require "em-websocket"
require "pp"
require "json"

require "./lib/client"
require "./lib/connection_manager"


server_options = {:host => 'localhost', :port => 8080}


CM = ConnectionManager.new
server_options = {:host => '0.0.0.0', :port => 8000}

EM.run do

  puts "Starting the Reactor..."
  puts "Socket: ws://#{server_options[:host]}:#{server_options[:port]}"

  EM::WebSocket.start(server_options) do |ws|

    ws.onopen { CM.add_socket(ws) }
    ws.onmessage { |msg| CM.process_message(ws, msg) }
    ws.onclose{ CM.remove_socket(ws) }

  end

  class App < Sinatra::Base

    get '/' do
      erb :index
    end

    get '/*' do
      redirect('/')
    end

  end

  App.run!({:port => 4567})
end