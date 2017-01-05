class TemplatesController < ApplicationController
  before_action :check_authorize_user
  
  def index
    @templates = Template.where(is_deleted: false)
  end
  
  def new
    @template = Template.new
  end
  
  def create
    @template = Template.new(template_params)
    if @template.save
      flash[:success] = 'Template successfully saved.'
      redirect_to templates_path
    else
      render 'new'
    end
  end
  
  def edit
    @template = Template.find_by_id(params[:id])
  end
  
  def update
    @template = Template.find_by_id(params[:id])
    @template.update_attributes(template_params)
    redirect_to templates_path
  end

  def destroy
    @template = Template.find_by_id(params[:id])
    @template.is_deleted = true
    @template.save!
    flash[:success] = 'Deleted successfully'
    redirect_to templates_path
  end
  
  def send_mail
    @template = Template.find_by_id(params[:id])
    @clients = Client.all
  end

  def send_mail_confirm
    # Make history
    template      = Template.find_by_id(params[:id])
    email_history = template.email_histories.build
    email_history.html       = template.html
    email_history.subject    = template.subject
    email_history.from_email = template.from
    email_history.save!
    
    # Send mail
    params[:multiselect] && params[:multiselect].each do |client_id|
      ClientMailer.delay.send_email(client_id, params[:id])
      client_history = email_history.history_clients.build
      client_history.client_id = client_id
      client_history.count = 1
      client_history.save!
    end
    
    flash[:success] = 'Send mail in process.'
    redirect_to templates_path
  end
  
  private
  def template_params
    params.require(:template).permit(:subject, :html, :from)
  end
end
