require 'rspec'
require 'test_helper'

describe "Global Chat Module" do
  include EventedSpec::EMSpec
  default_timeout 1

  before do
    CM = ConnectionManager.new
  end

  it "should only allow authenticated users to send messages" do
    # Unauthenticated
    fake_socket = FakeSocket.new
    fake_chat_message = {action: 'process_global_chat_message', data: {:message => 'hi everyone', :user => 'unauthenticated-user@email.com'}}
    CM.process_global_chat_message(fake_socket, fake_chat_message)
    fake_socket.last_response.should == nil

    # Authenticated
    fake_socket = FakeSocket.new
    login_data = {'email' => "authorized-user@email.com"}
    CM.login(fake_socket, login_data)
    fake_chat_message = {action: 'process_global_chat_message', data: {:message => 'hi everyone', :user => 'authorized-user@email.com'}}
    CM.process_global_chat_message(fake_socket, fake_chat_message)
    JSON(fake_socket.responses.last)['action'].should == 'global_chat_message'
    done
  end

  it "should return a hash with information about the user and their message" do
    fake_socket = FakeSocket.new
    login_data = {'email' => "hash-info@email.com"}
    CM.login(fake_socket, login_data)
    fake_chat_message = {action: 'process_global_chat_message', data: {:message => 'hi everyone', :user => 'authorized-user@email.com'}}
    CM.process_global_chat_message(fake_socket, fake_chat_message)
    response = JSON(fake_socket.responses.last)
    pp response
    JSON(fake_socket.responses.last)['data']['user']['email'].nil?.should == false
    JSON(fake_socket.responses.last)['data']['message'].nil?.should == false
    JSON(fake_socket.responses.last)['data']['timestamp'].nil?.should == false
  end

end