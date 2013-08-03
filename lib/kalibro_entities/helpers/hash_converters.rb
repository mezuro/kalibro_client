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

module HashConverters
  def convert_to_hash(value)
    return value if value.nil?
    return value.collect { |element| convert_to_hash(element) } if value.is_a?(Array)
    return value.to_hash if value.is_a?(KalibroEntities::Entities::Model)
    return self.class.date_with_milliseconds(value) if value.is_a?(DateTime)
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