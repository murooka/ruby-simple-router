# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'router/version'

Gem::Specification.new do |spec|
  spec.name          = "router"
  spec.version       = Router::VERSION
  spec.authors       = ["Naoki Yaguchi"]
  spec.email         = ["murooka.1129.x50@gmail.com"]

  spec.summary       = %q{lightweight http router}
  spec.description   = %q{lightweight http router implementation}
  spec.homepage      = "https://github.com/murooka/ruby-simple-router"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
