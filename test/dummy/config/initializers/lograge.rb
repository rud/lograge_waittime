Rails.application.configure do
  config.logger = ActiveSupport::Logger.new(STDOUT)
  
  config.lograge.enabled = true

  # Keep emitting the verbose logging for easier debug
  config.lograge.keep_original_rails_log = true
end
