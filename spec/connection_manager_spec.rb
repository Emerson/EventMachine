require 'rspec'
require 'test_helper'

describe "ConnectionManager" do
  #include EventedSpec::SpecHelper
  include EventedSpec::EMSpec
  default_timeout 1

  before do
    $fake_message = false
  end

  it "should contain a hash of sockets" do
    CM = ConnectionManager.new
    CM.sockets.class.should eq(Hash)
    done
  end

  it "should add websocket connections to the socket pool" do
    fake_socket = FakeSocket.new
    CM.add_socket(fake_socket)
    CM.sockets[fake_socket.signature].should == fake_socket
    done
  end

  it "should remove websocket connections from the pool" do
    fake_socket = FakeSocket.new
    CM.add_socket(fake_socket)
    CM.remove_socket(fake_socket)
    CM.sockets[fake_socket].should == nil
    done
  end

  it "should dynamically process messages from json strings" do
    fake_socket = FakeSocket.new
    fake_message = {:action => 'fake_action', :data => {:some_key => 'has some data'}}.to_json
    # Add a fake response
    def CM.fake_action(socket, data)
      $fake_message = true
    end
    CM.process_message(fake_socket, fake_message)
    $fake_message.should == true
    done
  end

end