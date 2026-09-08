# BpObfuscate

[![CI](https://github.com/burningpony/bp_obfuscate/actions/workflows/ci.yml/badge.svg)](https://github.com/burningpony/bp_obfuscate/actions/workflows/ci.yml)

A simple wrapper around OpenSSL to easily encrypt/obfuscate data.

Inside a Rails application the key comes from the app's `secret_key_base`;
outside of Rails it comes from `ENV["SECRET_KEY_BASE"]`. Works on Rails 4.1
through Rails 8.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bp_obfuscate'
```

And then run `bundle`. Or install it yourself as:

    $ gem install bp_obfuscate

## Usage

```ruby
token = Obfuscate.encrypt("user-42")   # => "rIMK7MWO-u-gLdi7qVKU8A=="
Obfuscate.decrypt(token)               # => "user-42"
Obfuscate.decrypt("garbage")           # => nil
```

`decrypt` returns `nil` instead of raising when it can't decrypt a value, so
it's safe to call on untrusted input such as a URL parameter.

If no key is available, `BpObfuscate::NoCipherKey` is raised.

## Development

Run `bin/setup` to install dependencies, `bundle exec rspec` for the tests, and
`bin/console` for an interactive prompt.

To release a new version, update the version number in `version.rb` and run
`bundle exec rake release`.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/rposborne/bp_obfuscate.

## License

Available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
