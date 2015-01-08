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

describe KalibroClient do

  context 'configuration' do
    #FIXME: there should be a better way to keep the default values
    let(:config) { { processor_address: "http://localhost:8082",
                   configurations_address: "http://localhost:8083" } }

    describe 'config' do
      it 'should return the default configuration' do
        expect(KalibroClient.config).to eq({
          processor_address: "http://localhost:8082",
          configurations_address: "http://localhost:8083"
        })
      end
    end

    describe 'configure' do
      after(:each) {KalibroClient.configure(config)}

      it 'should set the address' do
        KalibroClient.configure({processor_address: 'http://test.test'})
        expect(KalibroClient.config[:processor_address]).to eq('http://test.test')
      end
    end

    describe 'configure_with' do
      context 'with an existent YAML' do
        after(:each) {KalibroClient.configure(config)}

        it 'should set the config' do
          KalibroClient.configure_with('spec/savon/fixtures/config.yml')

          expect(KalibroClient.config).to eq({
            processor_address: 'http://test1.test1',
            configurations_address: 'http://test2.test2'})
        end
      end

      context 'with an inexistent YAML' do
        before :each do
          @logger = Logger.new(File::NULL)
          KalibroClient.expects(:logger).returns(@logger)
        end

        it 'should keep the defaults' do
          KalibroClient.configure_with('spec/savon/fixtures/inexistent_file.yml')
          expect(KalibroClient.config).to eq(config)
        end

        it 'should log an warning' do
          @logger.expects(:warn).with("YAML configuration file couldn't be found. Using defaults.")

          KalibroClient.configure_with('spec/savon/fixtures/inexistent_file.yml')
        end
      end

      context 'with an invalid YAML' do
        before :each do
          @logger = Logger.new(File::NULL)
          KalibroClient.expects(:logger).returns(@logger)
        end

        it 'should keep the defaults' do
          KalibroClient.configure_with('spec/savon/fixtures/invalid_config.yml')
          expect(KalibroClient.config).to eq(config)
        end

        it 'should log an warning' do
          @logger.expects(:warn).with("YAML configuration file contains invalid syntax. Using defaults.")

          KalibroClient.configure_with('spec/savon/fixtures/invalid_config.yml')
        end
      end
    end
  end

  context 'Logger' do
    describe 'logger' do
      it 'should return the default logger' do
        expect(KalibroClient.logger).to be_a(Logger)
      end
    end

    describe 'logger=' do
      it 'should set the logger' do
        logger = Logger.new(STDOUT)

        KalibroClient.logger = logger

        expect(KalibroClient.logger).to eq(logger)
      end
    end
  end
end
