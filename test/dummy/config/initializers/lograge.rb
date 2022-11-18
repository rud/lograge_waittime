Rails.application.configure do
  config.lograge.enabled = true

  # Keep emitting the verbose logging for easier debug
  config.lograge.keep_original_rails_log = !Rails.env.production?

  config.lograge.custom_options = lambda do |_event|
    custom_options = {}

    # lograge_waittime setup:
    queued_ms = ::RequestStore[:lograge_waittime].queued_ms
    custom_options[:wait] = queued_ms.round(2) if queued_ms

    custom_options
  end
end
