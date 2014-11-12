# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kalibro_client/version'

Gem::Specification.new do |spec|
  spec.name          = "kalibro_client"
  spec.version       = KalibroClient::VERSION
  spec.authors       = ["Diego Araújo Martinez", "Daniel Alves Paulino", "Heitor Reis Ribeiro", "Rafael Reggiani Manzo"]
  spec.email         = ["diegamc90@gmail.com", "danpaulalves@gmail.com", "marcheing@gmail.com", "rr.manzo@gmail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
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
