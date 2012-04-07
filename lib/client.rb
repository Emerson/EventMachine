class Client

  attr_accessor :email, :socket, :sids, :token

  def initialize(email, socket)
    @email = email
    @socket = socket
    @token = rand(36**8).to_s(36)
    @sids = []
  end

end