require "values"

module Tsclient
  class Profile < Value.new(:identifier, :name, :profile_pic_url, :human)
    def self.from(data)
      with(
        identifier: data.dig("UserProfile", "LoginName"),
        name: data.dig("UserProfile", "DisplayName"),
        profile_pic_url: data.dig("UserProfile", "ProfilePicURL"),
        human: data.dig("UserProfile", "LoginName").include?("@")
      )
    end

    def human?
      human
    end
  end
end
