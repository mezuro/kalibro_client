# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kalibro_client/version'

Gem::Specification.new do |spec|
  spec.name          = "kalibro_client"
  spec.version       = KalibroClient::VERSION
  spec.authors       = ["Diego Araújo Martinez", "Daniel Alves Paulino", "Heitor Reis Ribeiro", "Rafael Reggiani Manzo"]
  spec.email         = ["diegamc90@gmail.com", "danpaulalves@gmail.com", "marcheing@gmail.com", "rr.manzo@gmail.com"]
  spec.summary       = "Interface for the Kalibro Processor and Configurations webservices"
  spec.description   = "Programmable interface for accessing the webservices that compose the Kalibro code analysis tool: Processor and Configurations"
  spec.homepage      = "https://github.com/mezuro/kalibro_client"
  spec.license       = "LGPLv3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "mocha", "~> 1.1.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "factory_girl", "~> 4.4.0"

  spec.add_dependency 'activeresource', '~> 4.0.0'
end
