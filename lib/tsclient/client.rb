# frozen_string_literal: true

require "net/http"
require "json"

require_relative "./result"
require_relative "./profile"

module Tsclient
  class Client
    def initialize(uri:)
      @api_uri = uri.freeze
      freeze
    end

    def tailscale_ips
      api_get(:status).result.dig("TailscaleIPs")
    end

    def whois(addr)
      unless addr.include?(":")
        addr += ":80"
      end
      response = api_get(:whois, addr: addr)
      if response.error?
        nil
      else
        Profile.from(response.result)
      end
    end

    private

    def api_get(endpoint, params = {})
      case @api_uri.scheme
      when "http", "https"
        # All we actually need is the port & password, but expect well formed URI to be passed in
        Net::HTTP.start(@api_uri.host, @api_uri.port, use_ssl: (@api_uri.scheme == "https")) do |http|
          req = Net::HTTP::Get.new("/localapi/v0/#{endpoint}?#{params.map { |k, v| "#{k}=#{v}" }.join("&")}")
          req.basic_auth "", @api_uri.password
          req.content_type = "application/json"
          res = http.request(req)
          case res
          when Net::HTTPOK
            Result.with(error: false, result: JSON.parse(res.body))
          when Net::HTTPNotFound
            Result.with(error: true, result: res)
          end
        end
      when "unix"
        raise NotImplemented, "unix socket not implemented"
      else
        raise "Can't handle api uri with scheme #{@api_uri.scheme.inspect}"
      end
    end
  end
end
