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


end