# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bp_obfuscate/version"

Gem::Specification.new do |spec|
  spec.name          = "bp_obfuscate"
  spec.version       = BpObfuscate::VERSION
  spec.authors       = ["Russell Osborne"]
  spec.email         = ["russell@burningpony.com"]

  spec.summary       = "A simple wrapper to Open ssl to easily encrypt/obfuscate data."
  spec.homepage      = "https://burningpony.com"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
