require 'kalibro_entities/kalibro_cucumber_helpers/configuration'

module KalibroEntities
  module KalibroCucumberHelpers
    @configuration = KalibroEntities::KalibroCucumberHelpers::Configuration.new

    def KalibroCucumberHelpers.configure(&config_block)
      config_block.call(@configuration)
    end

    def KalibroCucumberHelpers.configuration
      @configuration
    end
  end
end