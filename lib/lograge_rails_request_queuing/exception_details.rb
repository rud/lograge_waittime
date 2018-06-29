module LogrageRailsRequestQueuing
  class ExceptionDetails
    # If the current request has an exception attached, add the exception details
    # and backtrace to the logging custom options
    def self.add_any_exception!(event, log_custom_options)
      if event.payload[:exception_object]
        log_custom_options[:exception] = event.payload[:exception]
        log_custom_options[:backtrace] = Array(event.payload[:exception_object].backtrace)
      end
      nil
    end
  end
end
