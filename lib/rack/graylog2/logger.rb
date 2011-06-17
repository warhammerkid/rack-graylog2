module Rack::Graylog2
  class Logger < ::GELF::Logger
    def initialize *args
      @buffer = {}
      super(*args)
    end

    def start_request
      @buffer[Thread.current] = []
    end

    def end_request success
      buf = @buffer.delete(Thread.current)
      return unless buf.size > 0
      data = {
        'level' => success ? ::GELF::INFO : ::GELF::ERROR,
        'short_message' => buf[0],
        'full_message' => buf.join
      }

      begin
        notify!(data)
      rescue => err
        puts "Could not log request: #{err}"
      end
    end

    def add severity, *args
      return unless @enabled
      return unless severity >= level

      if @buffer.key?(Thread.current)
        # Buffered logging
        message = (args[0] || (block_given? && yield) || args[1]).to_s
        message = "#{message}\n" unless message[-1] == ?\n
        @buffer[Thread.current] << message
        message
      else
        # Standard logging
        super(severity, *args)
      end
    end
  end
end