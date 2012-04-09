require 'rspec'
require 'test_helper'

describe "Authentication Module" do
  include EventedSpec::EMSpec
  default_timeout 1

  it "should store the socket signature, email, and password" do
  	fake_socket = FakeSocket.new
  	client = Client.new(fake_socket, 'authentication1@email.com')
  	client.signature.should == fake_socket.signature
  	done
  end

  it "should generate a unique token and private token on creation" do
  	fake_socket = FakeSocket.new
  	client = Client.new(fake_socket, 'authentication2@email.com')
  	client.token.nil?.should == false
  	client.private_token.nil?.should == false
  	client.token.should_not == client.private_token
  	done
  end

end