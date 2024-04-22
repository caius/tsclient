require "spec_helper"

describe Tsclient::ApiFinder do
  describe "with TSCLIENT_API_URI set" do
    it "returns that as URI" do
      # ENV is string keyed
      fake_env = {"TSCLIENT_API_URI" => "unix:///tmp/tailscaled.sock"}

      uri = Tsclient::ApiFinder.new.call(env: fake_env)

      _(uri).must_equal(URI(fake_env["TSCLIENT_API_URI"]))
    end
  end

  describe "on macOS with Tailscale.app running" do
    it "returns URI::HTTP with auth and port" do
      # Setup a home dir with the correct file path we expect on macOS to find port/password in filename
      fake_home = Dir.mktmpdir(%w[tsclient spec]).tap do |home|
        dir = Pathname.new(home).join("Library", "Group Containers", "#{SecureRandom.alphanumeric(5)}.io.tailscale.ipn.macos")
        dir.mkpath
        dir.join("sameuserproof-1337-totes1sekrit").write("")
      end
      fake_env = {"HOME" => fake_home.to_s}

      uri = Tsclient::ApiFinder.new.call(env: fake_env, ruby_platform: "arm64-darwin21")

      _(uri).must_equal(URI("http://:totes1sekrit@localhost:1337"))
    ensure
      FileUtils.remove_entry(fake_home) if defined?(fake_home)
    end
  end

  describe "on macOS without Tailscale.app running" do
    it "returns no uri" do
      fake_home = Dir.mktmpdir(%w[tsclient spec])
      fake_env = {"HOME" => fake_home}

      uri = Tsclient::ApiFinder.new.call(env: fake_env, ruby_platform: "arm64-darwin21")

      _(uri).must_be_nil
    end
  end

  # describe "on linux with default socket present"
  # describe "on linux with default socket missing"

  describe "when unable to find api" do
    it "returns nil" do
      # Empty env means no TSCLIENT_API_URI, no finding macOS file
      uri = Tsclient::ApiFinder.new.call(env: {})

      _(uri).must_be_nil
    end
  end
end
