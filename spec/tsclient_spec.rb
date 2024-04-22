# frozen_string_literal: true

require "spec_helper"

describe Tsclient do
  it "has a version number" do
    value(Tsclient::VERSION).wont_be_nil
  end

  describe ".default_client" do
    # Revert memoization between specs
    after do
      Tsclient.__send__ :remove_instance_variable, :@default_client if Tsclient.instance_eval { defined?(@default_client) }
    end

    describe "with found api" do
      subject { Tsclient.default_client(api_finder: -> { "unix:///run/tailscale/tailscaled.sock" }) }

      it "returns client" do
        value(subject).must_be_kind_of(Tsclient::Client)
      end

      it "memoizes the created client" do
        client = subject
        client2 = subject

        value(client.object_id).must_equal(client2.object_id)
      end
    end

    describe "without finding api" do
      it "raises error" do
        assert_raises {
          Tsclient.default_client(api_finder: -> {})
        }
      end
    end
  end
end
