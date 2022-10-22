# frozen_string_literal: true

require_relative "lib/tsclient/version"

Gem::Specification.new do |spec|
  spec.name = "tsclient"
  spec.version = Tsclient::VERSION
  spec.authors = ["Caius Durling"]
  spec.email = ["dev@caius.name"]

  spec.summary = "Tailscale localapi client"
  spec.description = "Interrogate Tailscale on your local machine through the local HTTP api."
  spec.homepage = "https://github.com/caius/tsclient"
  spec.license = "MIT"

  # We support ruby versions still supported by core
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_dependency "values", "~> 1.8"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "standard", "~> 1.3"
end
