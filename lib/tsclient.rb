# frozen_string_literal: true

require_relative "tsclient/client"

module Tsclient
  def self.default_client
    return @default_client if defined?(@default_client)

    # Attempt to setup the default client from various known strategies
    # Envariables override everything
    uri = if ENV.key?("TS_LOCALAPI_PORT")
      URI("http://:#{ENV["TS_LOCALAPI_KEY"]}@localhost:#{ENV["TS_LOCALAPI_PORT"]}")

    # Running on macOS, need to find api deets from filesystem
    elsif RUBY_PLATFORM["darwin"]
      tsfile = Pathname.glob("#{ENV["HOME"]}/Library/Group Containers/*.io.tailscale.ipn.macos/sameuserproof-*-*").first
      _, port, password = tsfile.basename.to_s.split("-", 3)
      URI("http://:#{password}@localhost:#{port}")
    # Throw our hands in the air, we just don't ~~care~~ know
    else
      raise NotImplemented, "Can't figure out where localapi is"
    end

    @default_client = Client.new(uri: uri)
  end
end
