class Client

  attr_accessor :email, :socket

  def initialize(email, socket)
    @email = email
    @socket = socket
  end

end