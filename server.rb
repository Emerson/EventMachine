require "rubygems"
require "sinatra/base"
require "eventmachine"
require "em-websocket"
require "pp"
require "json"

require "./lib/modules/authentication"
require "./lib/client"
require "./lib/connection_manager"


if ARGV.first == 'test'
  em_options = {:host => 'localhost', :port => 9999}
  sinatra_options = {:port => 8888}
else
  em_options = {:host => 'localhost', :port => 8080}
  sinatra_options = {:port => 4567}
end

CM = ConnectionManager.new

EM.run do

  puts "Starting the Reactor..."
  puts "Socket: ws://#{em_options[:host]}:#{em_options[:port]}"

  EM::WebSocket.start(em_options) do |ws|

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

  App.run!(sinatra_options)
end