Rails.application.configure do |config|
  
  config.active_job.queue_adapter = :resque
  
  config.scanner = config_for(:scanner).deep_symbolize_keys
end