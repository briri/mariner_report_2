Rails.application.configure do 
  config.jobs = config_for(:jobs).deep_symbolize_keys
end