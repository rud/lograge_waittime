module LogrageRailsRequestQueuing
  # Meant to be prepended in ActionDispatch::DebugExceptions like this:
  #
  #   ActionDispatch::DebugExceptions.prepend(
  #     LogrageRailsRequestQueuing::SilenceExceptionLogging
  #   )
  module SilenceExceptionLogging

    # Normally ActionDispatch::DebugExceptions will print exception details
    # and a full stacktrace to the Rails log. This stops that behavior:
    def log_error *_args
      # pass
    end
  end
end
