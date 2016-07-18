require 'msgpack/rpc'

module ZatsuKvs
  class Client

    def initialize(address = 'localhost', port = 24000)
      @cli = MessagePack::RPC::Client.new(address, port)
      @cli.timeout = 5
    end

    def get(key)
      @cli.call(:get, key)
    end

    def set(key, value)
      @cli.call(:set, key, value)
    end

    def backup
      @cli.call(:backup)
    end

  end
end
