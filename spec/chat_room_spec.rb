require 'rspec'
require 'test_helper'

describe "ChatRoom Module" do
  include EventedSpec::EMSpec
  default_timeout 1

  before do
    CM = ConnectionManager.new
  end

  it "should add an instance variable named rooms" do
    rooms = CM.rooms
    CM.instance_variable_defined?(:@rooms).should == true
    done
  end

  it "should allow authenticated users to add rooms" do
    fake_create_message = {action: 'add_chat_room', data: {:name => 'My Chat'}}
    
    # Logged in User
    fake_socket = FakeSocket.new
    login_data = {'email' => "hash-info@email.com"}
    CM.login(fake_socket, login_data)
    CM.add_chat_room(fake_socket, fake_create_message)
    CM.rooms.length.should == 1

    # Logged out User
    fake_socket = FakeSocket.new
    CM.add_chat_room(fake_socket, fake_create_message)
    CM.rooms.length.should == 1
    done
    
  end

  it "should remove users when they disconnect" do
    done
  end

  it "should destroy itself once the room is empty" do
    # Logged in User
    fake_socket = FakeSocket.new
    login_data = {'email' => "hash-info@email.com"}
    CM.login(fake_socket, login_data)
    CM.add_chat_room(fake_socket, fake_create_message)
    CM.rooms.length.should == 1

    done
  end

end