Rails.application.configure do 
  config.scanner = config_for(:scanner).deep_symbolize_keys
end