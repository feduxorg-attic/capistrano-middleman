# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/middleman/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-middleman'
  spec.version       = Capistrano::Middleman::VERSION
  spec.authors       = ['Max Meyer']
  spec.email         = ['dev@fedux.org']
  spec.summary       = 'Middleman deploy strategy for capistrano'
  spec.homepage      = 'https://github.com/maxmeyer/capistrano-middleman'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'

  spec.add_runtime_dependency 'middleman', '~> 4.0'
  spec.add_runtime_dependency 'capistrano', '~> 3.0'
  spec.add_runtime_dependency 'rubyzip', '~>1.1.7'
end
