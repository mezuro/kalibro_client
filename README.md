# KalibroClient

[![Build Status](https://travis-ci.org/mezuro/kalibro_client.png?branch=master)](https://travis-ci.org/mezuro/kalibro_client)
[![Code Climate](https://codeclimate.com/github/mezuro/kalibro_client.png)](https://codeclimate.com/github/mezuro/kalibro_client)
[![Coverage Status](https://coveralls.io/repos/mezuro/kalibro_client/badge.png)](https://coveralls.io/r/mezuro/kalibro_client)

KalibroClient is a Ruby gem intended to be an interface for Ruby applications who want to use the open source code analysis webservice Kalibro (http://gitorious.org/kalibro/kalibro).

## Installation

Add this line to your application's Gemfile:

    gem 'kalibro_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kalibro_client

## Usage

KalibroClient is intended to be an easy interface that encapsulates the usage of all the Kalibro service's endpoints. So have a look at the available entities at `lib/kalibro_client/entities`.

All the entities are subclasses from `Model`, so have a good look at it. Specially notice that all the entities have methods:

* `save`
* `exists?`
* `find`
* `destroy`

These four methods should be useful.

We hope to make available soon a full documentation on RDoc that will make easier to understand all this.

A good example on how to get everything from KalibroClient should be Mezuro. So, have a look there for some examples.

### Cucumber helpers

Acceptance tests with the Kalibro webservice can be painful. But we've created cucumber hooks that make it easy.

Just add to your `env.rb` the following:

    require 'kalibro_client/kalibro_cucumber_helpers/hooks.rb'

The test configurations available are:

* database
* user
* password
* psql_file_path
* query_file_path
* kalibro_home
* tomcat_user
* tomcat_group
* tomcat_restart_command

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
7. Create new Pull Request
