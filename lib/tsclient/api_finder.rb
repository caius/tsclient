module Tsclient
  class ApiFinder
    def call(env: ENV, ruby_platform: RUBY_PLATFORM)
      if env.key?("TSCLIENT_API_URI")
        env.fetch("TSCLIENT_API_URI")
      elsif ruby_platform["darwin"]
        # Running on macOS, api port & auth are in a specific filename
        if (tsfile = Pathname.glob("#{env["HOME"]}/Library/Group Containers/*.io.tailscale.ipn.macos/sameuserproof-*-*").first)
          _, port, password = tsfile.basename.to_s.split("-", 3)
          "http://:#{password}@localhost:#{port}"
        end
      end
    end
  end
end
