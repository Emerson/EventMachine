class Client

  attr_accessor :email, :socket, :signature, :token, :private_token

  def initialize(socket, email)
  	@signature = socket.signature
    @email = email
    @socket = socket
    @token = rand(36**8).to_s(36)
    @private_token = rand(36**8).to_s(36)
  end

end