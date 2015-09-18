# This file is part of KalibroClient
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

describe KalibroClient::Entities::Processor::HotspotMetricResult do
  describe 'new' do
    context 'with the expected attributes' do
      let(:attributes) { FactoryGirl.build(:hotspot_metric_result).to_hash }
      subject { KalibroClient::Entities::Processor::HotspotMetricResult.new attributes } 

      it 'should cast the line_number attribute to an integer' do
        expect(subject.line_number).to be_a Integer
      end
    end
  end
end

