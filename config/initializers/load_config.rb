EMAILS = %w(jakesorce@gmail.com joesorce@comcast.net jscutah@gmail.com)

if Rails.env.development?
  CONFIG = YAML.load_file('config/configs.yml') rescue {}
elsif Rails.env.production?
  CONFIG = ENV
end