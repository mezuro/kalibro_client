# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kalibro_entities/version'

Gem::Specification.new do |spec|
  spec.name          = "kalibro_entities"
  spec.version       = KalibroEntities::VERSION
  spec.authors       = ["Daniel Paulino Alves", "Diego Araújo Martinez", "Guilherme Rojas V. de Lima", "Rafael Reggiani Manzo"]
  spec.email         = ["danpaulalves@gmail.com", "diegamc90@gmail.com", "guilhermehrojas@gmail.com", "rr.manzo@gmail.com"]
  spec.description   = "KalibroEntites is a communication interface with the Kalibro service."
  spec.summary       = "KalibroEntites is a communication interface with the Kalibro service."
  spec.homepage      = "https://github.com/mezuro/kalibro_entities"
  spec.license       = "LGPL"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "simplecov"
end
