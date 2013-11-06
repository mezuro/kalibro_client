# This file is part of KalibroGem
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

require 'spec_helper'
require 'kalibro_gem/helpers/xml_converters'

include XMLConverters

describe XMLConverters do
  describe 'xml_instance_class_name' do
    before { @model = KalibroGem::Entities::Model.new }

    it 'should return modelXml' do
      xml_instance_class_name(@model).should eq('modelXml')
    end
  end

  describe 'get_xml' do
    context 'with an object that is not an instance of Model' do
      before { @object = "kalibro" }

      it 'should return a Hash' do
        get_xml("field", @object).should be_a(Hash)
      end

      it 'should return an empty Hash' do
        get_xml("field", @object).should eq({})
      end
    end

    context 'with an instance of Model' do
      before { @object = KalibroGem::Entities::Model.new }

      it 'should return a Hash' do
        get_xml("field", @object).should be_a(Hash)
      end

      it 'should return the XML Hash' do
        field_xml_hash = {:attributes! =>
                            {:field =>
                              {"xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance", 
                               "xsi:type"=>"kalibro:modelXml"
                              }
                            }
                          }

        get_xml("field", @object).should eq(field_xml_hash)
      end
    end
  end
end