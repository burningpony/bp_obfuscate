# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bp_obfuscate/version"

Gem::Specification.new do |spec|
  spec.name          = "bp_obfuscate"
  spec.version       = BpObfuscate::VERSION
  spec.authors       = ["Russell Osborne"]
  spec.email         = ["russell@burningpony.com"]

  spec.summary       = "A simple wrapper around OpenSSL to easily encrypt/obfuscate data."
  spec.description   = "A small wrapper around OpenSSL for encrypting and obfuscating " \
                       "short values such as ids in URLs. Derives its key from a Rails " \
                       "application's secret_key_base, or from ENV[\"SECRET_KEY_BASE\"] " \
                       "outside of Rails."
  spec.homepage      = "https://github.com/burningpony/bp_obfuscate"
  spec.license       = "MIT"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage,
    "changelog_uri" => "#{spec.homepage}/blob/master/CHANGELOG.md",
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "rubygems_mfa_required" => "true"
  }

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/}) ||
      f.match(%r{^(\.github/|\.gitignore|\.rspec|Gemfile|Rakefile|bin/|CODE_OF_CONDUCT\.md)})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.7"

  # base64 stopped being a default gem in Ruby 3.4, so it has to be declared.
  # Deliberately open-ended: it is a stdlib shim, so any future version will do.
  spec.add_dependency "base64", ">= 0.1"

  spec.add_development_dependency "bundler", ">= 1.13", "< 5"
  spec.add_development_dependency "rake", ">= 12.0", "< 14"
  spec.add_development_dependency "rspec", "~> 3.0"
end
