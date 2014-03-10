# This file is part of KalibroGatekeeperClient
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
require 'kalibro_gatekeeper_client/version'

Gem::Specification.new do |spec|
  spec.name          = "kalibro_gatekeeper_client"
  spec.version       = KalibroGatekeeperClient::VERSION
  spec.authors       = ["Diego Araújo Martinez", "Fellipe Souto", "Rafael Reggiani Manzo", "Renan Fichberg"]
  spec.email         = ["diegamc90@gmail.com", "fllsouto@gmail.com", "rr.manzo@gmail.com", "rfichberg@gmail.com"]
  spec.description   = "KalibroGatekeeperClient is a Ruby gem intended to be an interface for KalibroGatekeeper WebService."
  spec.summary       = "KalibroGatekeeperClient is a communication interface with the KalibroGateKeeper service."
  spec.homepage      = "https://github.com/mezuro/kalibro_gatekeeper_client"
  spec.license       = "LGPLv3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "cucumber", "~> 1.3.11"
  spec.add_development_dependency "mocha", "~> 1.0.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "factory_girl", "~> 4.4.0"
  spec.add_development_dependency 'coveralls'

  spec.add_dependency "activesupport", "~> 4.1.0.rc1"
  spec.add_dependency "savon"
end
