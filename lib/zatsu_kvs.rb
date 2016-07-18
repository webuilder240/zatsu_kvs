require "zatsu_kvs/version"
require "zatsu_kvs/server"
require "zatsu_kvs/client"
require "msgpack/rpc"

module ZatsuKvs
  def self.run
    begin
      p '==================================='
      p "Zatsu KVS (Version: #{ZatsuKvs::VERSION}) Started"
      p '==================================='
      server = MessagePack::RPC::Server.new()
      server.listen('localhost', '24000', ZatsuKvs::Server.new())
      server.run()
    rescue Interrupt
      p '==================================='
      p 'Zatsu KVS Ended'
      p '==================================='
      ZatsuKvs::Server.backup()
      server.shutdown()
    end
  end
end
