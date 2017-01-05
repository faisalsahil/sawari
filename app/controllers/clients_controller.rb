class ClientsController < ApplicationController
  before_action :check_authorize_user
  
  def index
    @clients = Client.all
  end
  
  def new
    @client_import = Client.new
  end
  
  def import
    if params[:file].present?
      Client.import(params[:file])
      redirect_to clients_path, notice: 'Imported clients successfully.'
    else
      flash[:info] = 'No file Chosen.'
      redirect_to :back
    end
  end
end
