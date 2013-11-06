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

describe KalibroGem do

  context 'configuration' do
    #FIXME: there should be a better way to keep the default values
    let(:config) {{address: "http://localhost:8080/KalibroService/"}}

    describe 'config' do
      it 'should return the default configuration' do
        KalibroGem.config.should eq({
                                          address: "http://localhost:8080/KalibroService/"
                                        })
      end
    end

    describe 'configure' do
      after(:all) {KalibroGem.configure(config)}

      it 'should set the address' do
        KalibroGem.configure({address: 'http://test.test'})
        KalibroGem.config.should eq({address: 'http://test.test'})
      end
    end

    describe 'configure_with' do
      context 'with an existent YAML' do
        after(:all) {KalibroGem.configure(config)}

        it 'should set the config' do
          KalibroGem.configure_with('spec/savon/fixtures/config.yml')

          KalibroGem.config.should eq({address: 'http://test1.test1'})
        end
      end

      context 'with an inexistent YAML' do
        before :each do
          @logger = Logger.new(File::NULL)
          KalibroGem.expects(:logger).returns(@logger)
        end

        it 'should keep the defaults' do
          KalibroGem.configure_with('spec/savon/fixtures/inexistent_file.yml')
          KalibroGem.config.should eq({address: "http://localhost:8080/KalibroService/"})
        end

        it 'should log an warning' do
          @logger.expects(:warn).with("YAML configuration file couldn't be found. Using defaults.")

          KalibroGem.configure_with('spec/savon/fixtures/inexistent_file.yml')
        end
      end

      context 'with an invalid YAML' do
        before :each do
          @logger = Logger.new(File::NULL)
          KalibroGem.expects(:logger).returns(@logger)
        end

        it 'should keep the defaults' do
          KalibroGem.configure_with('spec/savon/fixtures/invalid_config.yml')
          KalibroGem.config.should eq({address: "http://localhost:8080/KalibroService/"})
        end

        it 'should log an warning' do
          @logger.expects(:warn).with("YAML configuration file contains invalid syntax. Using defaults.")

          KalibroGem.configure_with('spec/savon/fixtures/invalid_config.yml')
        end
      end
    end
  end

  context 'Logger' do
    describe 'logger' do
      it 'should return the default logger' do
        KalibroGem.logger.should be_a(Logger)
      end
    end

    describe 'logger=' do
      it 'should set the logger' do
        logger = Logger.new(STDOUT)

        KalibroGem.logger = logger

        KalibroGem.logger.should eq(logger)
      end
    end
  end
end