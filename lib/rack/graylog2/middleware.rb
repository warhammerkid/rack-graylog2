module Rack::Graylog2
  class Middleware
    def initialize app, logger
      raise "Invalid Graylog2 logger" unless logger.respond_to?(:start_request)
      @app = app
      @logger = logger
    end

    def call env
      @logger.start_request
      res = @app.call(env)
      @logger.end_request res[0] < 400 # 400 or 500 series bad
      res
    end
  end
end