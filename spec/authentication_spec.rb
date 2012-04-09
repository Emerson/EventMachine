require 'rspec'
require 'test_helper'

describe "Authentication Module" do
  include EventedSpec::EMSpec
  default_timeout 1

  before do
    CM = ConnectionManager.new
  end

  it "should add the client to the user pool after a successful login" do
    fake_socket = FakeSocket.new
    login_data = {'email' => 'authentication@email.com'}
    CM.login(fake_socket, login_data)
    CM.users[fake_socket.signature].email.should == 'authentication@email.com'
    done
  end

  it "should send out global message when a user logs in" do
    fake_socket = FakeSocket.new
    login_data = {'email' => 'authentication-global-add@email.com'}
    CM.login(fake_socket, login_data)
    response_hash = JSON(fake_socket.last_response)
    response_hash['action'].should == 'connected_users'
    done
  end

  it "should subscribe a logged in user to the global channel" do
    fake_socket = FakeSocket.new
    login_data = {'email' => 'authentication-global-channel@email.com'}
    CM.login(fake_socket, login_data)
    CM.global.instance_variable_get("@subs").count.should == 1
    done
  end

end