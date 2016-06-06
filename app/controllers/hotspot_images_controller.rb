class HotspotImagesController < ApplicationController
  before_action :set_hotspot_image, only: [:edit, :update, :destroy]
  
  def new
    @hotspot_image = HotspotImage.new
    binding.pry
  end
  
  def edit
  end
  
  def create
    @hotspot_image = HotspotImage.new(hotspot_image_params)
    if @hotspot_image.save
      flash[:notice] = 'Hotspot Image was successfully created.'
      redirect_to root_url(protocol: 'https')
    else
      flash[:error] = @hotspot_image.errors.full_messages
      redirect_to :back
    end
  end
  
  def update
    if @hotspot_image.update_attributes(hotspot_image_params)
      flash[:notice] =  'Hotspot Image was successfully updated.'
      redirect_to root_url(protocol: 'https')
    else
      flash[:error] = @hotspot_image.errors.full_messages
      redirect_to :back
    end
  end
  
  def destroy
    @hotspot_image.destroy
    flash[:notice] = 'Hotspot Image was successfully deleted'
    redirect_to root_url(protocol: 'https')
  end
  
  
  
  private
  
  def hotspot_image_params
    params.require("hotspot_image").permit("title")
  end
  
  def set_hotspot_image
    @hotspot_image = HotspotImage.find(params[:id])
  end
end
