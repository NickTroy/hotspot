class InterfacesController < ApplicationController
  before_action :set_interface, only: [:edit, :update, :destroy]
  
  def new
    @interface = Interface.new
  end
  
  def edit
  end
  
  def create
    @interface = Interface.new(interface_params)
    if @interface.save
      flash[:notice] = 'Interface was successfully created.'
      redirect_to root_url(protocol: 'https')
    else
      flash[:error] = @interface.errors.full_messages
      redirect_to :back
    end
  end
  
  def update
    if @interface.update_attributes(interface_params)
      flash[:notice] =  'Interface was successfully updated.'
      redirect_to root_url(protocol: 'https')
    else
      flash[:error] = @interface.errors.full_messages
      redirect_to :back
    end
  end
  
  def destroy
    @interface.destroy
    flash[:notice] = 'Interface was successfully deleted'
    redirect_to root_url(protocol: 'https')
  end
  
  
  
  private
  
  def interface_params
    params.require("interface").permit("title")
  end
  
  def set_interface
    @interface = Interface.find(params[:id])
  end
end
