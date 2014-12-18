require 'rake'
require 'rake/tasklib'

module KalibroClient
  module Rake
    class TestTask < ::Rake::TaskLib
      def initialize
        namespace :test do
          desc 'Runs acceptance and unit tests'
          task :all => [:units]

          desc 'Runs the unit tests'
          task :units do
            unit_tests_command = "bundle exec rspec spec"

            puts "Running the unit tests with \"#{unit_tests_command}\"\n\n"
            system unit_tests_command
          end
        end
      end
    end
  end
end
