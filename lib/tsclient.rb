# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

module Tsclient
  def self.default_client(api_finder: FindApiUri.new)
    return @default_client if defined?(@default_client)

    if (uri = api_finder.call)
      @default_client = Client.new(uri: uri)
    else
      raise Error.new("Could not find localapi on this machine")
    end
  end
end

loader.eager_load
