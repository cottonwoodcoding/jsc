if Rails.env.development?
  CONFIG = YAML.load_file('config/configs.yml') rescue {}
elsif Rails.env.production?
  CONFIG = ENV
end