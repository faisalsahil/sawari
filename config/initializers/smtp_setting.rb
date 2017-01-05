ActionMailer::Base.smtp_settings = {
    address: ENV['APIDOC_SMTP_ADDRESS_' + ENV['APIDOC_MODE']],
    domain: ENV['APIDOC_SMTP_DOMAIN_' + ENV['APIDOC_MODE']],
    user_name: ENV['APIDOC_SMTP_USERNAME_' + ENV['APIDOC_MODE']],
    password: ENV['APIDOC_SMTP_PASSWORD_' + ENV['APIDOC_MODE']],
    :port => 25,
    :authentication => :plain,
    :enable_starttls_auto => true
}