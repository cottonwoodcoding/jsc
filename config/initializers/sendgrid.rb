ActionMailer::Base.smtp_settings = {
    :user_name => CONFIG['sendgrid-username'],
    :password => CONFIG['sendgrid-password'],
    :domain => CONFIG['sendgrid-domain'],
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}