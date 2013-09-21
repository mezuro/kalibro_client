# This file is part of KalibroEntities
# Copyright (C) 2013  it's respectives authors (please see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kalibro_entities/version'

Gem::Specification.new do |spec|
  spec.name          = "kalibro_entities"
  spec.version       = KalibroEntities::VERSION
  spec.authors       = ["Daniel Paulino Alves", "Diego Araújo Martinez", "Guilherme Rojas V. de Lima", "Rafael Reggiani Manzo"]
  spec.email         = ["danpaulalves@gmail.com", "diegamc90@gmail.com", "guilhermehrojas@gmail.com", "rr.manzo@gmail.com"]
  spec.description   = "KalibroEntities is a Ruby gem intended to be an interface for Ruby applications who want to use the open source code analysis webservice Kalibro (http://gitorious.org/kalibro/kalibro)."
  spec.summary       = "KalibroEntites is a communication interface with the Kalibro service."
  spec.homepage      = "https://github.com/mezuro/kalibro_entities"
  spec.license       = "LGPLv3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "cucumber", "~> 1.3.5"
  spec.add_development_dependency "mocha", "~> 0.14.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "factory_girl", "~> 4.2.0"
  spec.add_development_dependency 'coveralls'

  spec.add_dependency "savon", "~> 2.3.0"
  spec.add_dependency "activesupport", "~> 4.0.0"
end
