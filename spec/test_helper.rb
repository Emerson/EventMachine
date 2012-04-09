require 'eventmachine'
require 'evented-spec'
require 'json'

lib_path = File.dirname(File.dirname(__FILE__))
require lib_path+'/lib/modules/authentication.rb'
require lib_path+'/lib/connection_manager.rb'
require lib_path+'/lib/client.rb'



class FakeSocket

  attr_accessor :signature, :last_response, :responses

  def initialize
  	@responses = []
    @signature = rand(36**8).to_s(36)
  end

  def send(response)
  	@responses << response
    @last_response = response
  end

end