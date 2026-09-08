# Changelog

All notable changes to this project are documented in this file.

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.1] - 2026-09-08

### Added

- Rails 8 support.
- `base64` as an explicit runtime dependency; it stopped being a default gem in
  Ruby 3.4, so `require "base64"` raised `LoadError` under Bundler there.
- GitHub Actions CI covering Ruby 2.7 through 3.4 plus ruby-head.
- A real README, and this changelog.

### Fixed

- `cipher_key` called `Rails.application.secrets`, which was removed in Rails
  7.1, raising `NoMethodError` on every encrypt/decrypt under Rails 7.1 and 8.
  The key now comes from `Rails.application.secret_key_base`, falling back to
  the old `secrets` lookup for Rails versions that predate it.
- `defined?(Rails)` was true whenever any Rails constant was loaded, so the key
  lookup could run with a `nil` `Rails.application` and raise.
- `raise NoCipherKey` raised `NameError`, because the constant lives in
  `BpObfuscate` rather than `Obfuscate`. `BpObfuscate::NoCipherKey` is now
  raised as documented.
- `rescue OpenSSL::Cipher::CipherError && ArgumentError` evaluated to just
  `ArgumentError`, so `decrypt` raised `CipherError` on undecryptable input
  instead of returning `nil`.
- Added the missing `require "digest"`, which had been working only via
  whatever else happened to load it.
- `rake` failed with "Don't know how to build task 'spec'"; the `:spec` task is
  now defined.

### Changed

- `required_ruby_version` is now `>= 2.7`.
- Relaxed the `bundler ~> 1.13` and `rake ~> 10.0` development pins, which
  could not resolve on a Ruby new enough to run Rails 8.
- Development and CI files are no longer packaged into the built gem.

## [0.1.1] - 2017-04-30

### Fixed

- Deprecation warning from `OpenSSL::Cipher::Cipher`.

## [0.1.0] - 2017-01-31

- Initial release.

[0.2.1]: https://github.com/burningpony/bp_obfuscate/compare/v0.1.1...v0.2.1
[0.1.1]: https://github.com/burningpony/bp_obfuscate/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/burningpony/bp_obfuscate/releases/tag/v0.1.0
