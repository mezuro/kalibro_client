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

require 'date'
require 'kalibro_gatekeeper_client/helpers/xml_converters'

module HashConverters
  include XMLConverters

  #FIXME: we can think about a better name. This method actually receives an DateTime and converts it to string
  def date_with_milliseconds(date)
    milliseconds = "." + (date.sec_fraction * 60 * 60 * 24 * 1000).to_s
    date.to_s[0..18] + milliseconds + date.to_s[19..-1]
  end

  def convert_to_hash(value)
    return value if value.nil?
    return value.collect { |element| convert_to_hash(element) } if value.is_a?(Array)
    return value.to_hash if value.is_a?(KalibroGatekeeperClient::Entities::Model)
    return date_with_milliseconds(value) if value.is_a?(DateTime)
    return 'INF' if value.is_a?(Float) and value.infinite? == 1
    return '-INF' if value.is_a?(Float) and value.infinite? == -1
    value.to_s
  end

  def field_to_hash(field)
    hash = Hash.new
    field_value = send(field)
    if !field_value.nil?
      hash[field] = convert_to_hash(field_value)
      hash = get_xml(field, field_value).merge(hash)
    end
    hash
  end
end