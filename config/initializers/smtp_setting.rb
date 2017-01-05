ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    domain: 'appsgenii.com',
    user_name: 'appsgenii_apidoc',
    password: 'App@G3n11D3v',
    :port => 25,
    :authentication => :plain,
    :enable_starttls_auto => true
}