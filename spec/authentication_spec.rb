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
    response_hash['action'].should == 'authenticated_users'
    done
  end

  it "should subscribe a logged in user to the global channel" do
    fake_socket = FakeSocket.new
    login_data = {'email' => 'authentication-global-channel@email.com'}
    CM.login(fake_socket, login_data)
    CM.global.instance_variable_get("@subs").count.should == 1
    done
  end

  it "should send a list of authenticated users" do
    fake_socket = false
    2.times do |index|
      fake_socket = FakeSocket.new
      login_data = {'email' => "authentication-user-list-#{index}@email.com"}
      CM.login(fake_socket, login_data)
    end
    CM.authenticated_users(fake_socket)
    response_hash = JSON(fake_socket.last_response)
    response_hash['data']['online_users'].should == 2
    response_hash['data']['users'].shift[1]['email'].should == "authentication-user-list-0@email.com"
    done
  end

  it "should authenticate a socket" do
    fake_socket = FakeSocket.new
    login_data = {'email' => "authorized-user@email.com"}
    CM.login(fake_socket, login_data)
    CM.authorized?(fake_socket).should == true
    unauthorized_socket = FakeSocket.new
    CM.authorized?(unauthorized_socket).should == false
    done
  end

  it "should return a user when given a socket" do
    fake_socket = FakeSocket.new
    login_data = {'email' => "return-me@email.com"}
    CM.login(fake_socket, login_data)
    CM.user_for_socket(fake_socket).instance_of?(Client).should == true
    done
  end

end