require 'gelf'
require 'rack/graylog2/version'
require 'rack/graylog2/logger'
require 'rack/graylog2/middleware'

module Rack #:nodoc:
  # Rack middleware that batches all log calls by request rather than by line.
  #
  # Rails 2:
  #
  #    require 'rack/graylog2'
  #    config.active_record.colorize_logging = false # Disable ANSI codes
  #    config.logger = ::Rack::Graylog2::Logger.new # GELF::Notifier arguments 
  #    config.middleware.insert_before "ActionController::Failsafe", "Rack::Graylog2", config.logger
  module Graylog2
    def self.new app, args ={}
      Rack::Graylog2::Middleware.new(app, args)
    end
  end
end