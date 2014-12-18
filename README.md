# KalibroClient

Programmable interface for accessing the webservices that compose the Kalibro code analysis tool: Processor and Configurations

## Installation

Add this line to your application's Gemfile:

    gem 'kalibro_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kalibro_client

## Usage

KalibroClient is intended to be an easy interface that encapsulates the usage of all the Kalibro service's endpoints. So have a look at the available entities at `lib/kalibro_client/processor` and `lib/kalibro_client/configuration`.

e hope to make available soon a full documentation on RDoc that will make easier to understand all this.

A good example on how to get everything from KalibroClient should be Prezento. So, have a look there for some examples.

### Cucumber helpers

Acceptance tests with the Kalibro webservice can be painful. But we've created cucumber hooks that make it easy.

Just add to your `env.rb` the following:

    require 'kalibro_client/kalibro_cucumber_helpers/hooks.rb'

The test configurations available are:

* kalibro_processor_address
* kalibro_configuration_address

An example on how to change them is:

    KalibroClient::KalibroCucumberHelpers.configure do |config|
      config.database = "kalibro_test"
    end

We hope to make available soon an YAML parser for test configurations.

## Contributing

0. Install RVM (rvm.io)
1. Fork it
2. Run `bundle install`
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Make your modifications and changes
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new Pull Request
