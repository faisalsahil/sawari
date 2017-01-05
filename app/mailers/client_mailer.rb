class ClientMailer < ApplicationMailer
  # default from: 'info@appsgenii.com'
  def send_email(client_id, template_id)
    @template     = Template.find_by_id(template_id)
    @client       = Client.find_by_id(client_id)
    @html_content = content_setting(@template.html, @client)
    subject       = content_setting(@template.subject, @client)
    mail(:to => @client.email, :subject => subject, :from => @template.from)
  end

  def send_email_from_history(client_id, history_id)
    @email_history = EmailHistory.find_by_id(history_id)
    @client        = Client.find_by_id(client_id)
    @html_content  = content_setting(@email_history.html,    @client)
    subject        = content_setting(@email_history.subject, @client)
    mail(:to => @client.email, :subject => subject, :from => @email_history.from_email)
  end
  
  def content_setting(content, client)
    if client.email.present?
      content = content.gsub("{{EMAIL}}", client.email)
    else
      content = content.gsub("{{EMAIL}}", 'EMAIL')
    end

    if client.full_name.present?
      content = content.gsub("{{FULL_NAME}}", client.full_name)
    else
      content = content.gsub("{{FULL_NAME}}", 'FULL_NAME')
    end

    if client.first_name.present?
      content = content.gsub("{{FIRST_NAME}}", client.first_name)
    else
      content = content.gsub("{{FIRST_NAME}}", 'FIRST_NAME')
    end

    if client.last_name.present?
      content = content.gsub("{{LAST_NAME}}",  client.last_name)
    else
      content = content.gsub("{{LAST_NAME}}",  'LAST_NAME')
    end

    if client.company.present?
      content = content.gsub("{{COMPANY}}",    client.company)
    else
      content = content.gsub("{{COMPANY}}",    'COMPANY')
    end

    if client.phone.present?
      content = content.gsub("{{PHONE}}",      client.phone)
    else
      content = content.gsub("{{PHONE}}",      'PHONE')
    end

    if client.url.present?
      content = content.gsub("{{URL}}",        client.url)
    else
      content = content.gsub("{{URL}}",        '\/')
    end
    
    content
  end
  
  # def subject_setting(subject, client)
  #   subject = subject.gsub("{{EMAIL}}", client.email)           if client.email.present?
  #   subject = subject.gsub("{{FULL_NAME}}", client.full_name)   if client.full_name.present?
  #   subject = subject.gsub("{{FIRST_NAME}}", client.first_name) if client.first_name.present?
  #   subject = subject.gsub("{{LAST_NAME}}",  client.last_name)  if client.last_name.present?
  #   subject = subject.gsub("{{COMPANY}}", client.company)       if client.company.present?
  #   subject = subject.gsub("{{PHONE}}", client.phone)           if client.phone.present?
  #   subject
  # end
end
