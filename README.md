# Tsclient

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

Client library wrapping the [Tailscale localapi][localapi]. This lets you do things like find out the identity of another machine talking to you on the tailnet, or interrogate the current machine's info.

Tsclient attempts to figure out the correct url for your [Tailscale localapi][localapi] based on what Operating System you are running. On macOS it connects over localhost to the randomly assigned port with the randomly generated password, provided you're running `Tailscale.app` as the same user as the ruby process. On linux it assumes the tailscaled socket is in the default location in `/run`.

If you're running a custom setup and need to tell `Tsclient` where your `tailscaled` socket is, you can either set `TSCLIENT_API_URI` to either a `http://` or `unix://` URI, or programatically you can pass it as an argument when creating an instance of `Tsclient::Client`.

[localapi]: https://github.com/tailscale/tailscale/blob/main/ipn/localapi/localapi.go

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add tsclient

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install tsclient

## Usage

```ruby
client = Tsclient.default_client
# => #<Tsclient::Client …>

tsips = client.tailscale_ips
# => ["100.100.100.1", "fd7a:115c:a1e0::1"]

client.whois tsips.first
# => #<Tsclient::Profile identifier="bob.bobbity@example.com", name="Bob Bobbity", profile_pic_url="https://www.google.com/images/errors/robot.png", human=true>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/caius/tsclient. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/caius/tsclient/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tsclient project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/caius/tsclient/blob/main/CODE_OF_CONDUCT.md).
