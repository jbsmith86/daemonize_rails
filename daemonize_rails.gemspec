# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'daemonize_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "daemonize_rails"
  spec.version       = DaemonizeRails::VERSION
  spec.authors       = ["Joel Smith"]
  spec.email         = ["joel@trosic.com"]
  spec.summary       = "Daemonize Rails is a Gem to make a system process for your Rails app."
  spec.description   = "Daemonize Rails will configure your server to add a new process for your rails app in production."
  spec.homepage      = "http://www.github.com/jbsmith86/daemonize_rails"
  spec.license       = "BSD-3-Clause-Clear"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.executables   = ["daemonize_rails"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
