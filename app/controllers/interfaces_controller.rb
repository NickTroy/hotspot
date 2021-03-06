class InterfacesController < AuthenticatedController
  before_action :set_interface, only: [:edit, :update, :destroy]
  
  def new
    @interface = Interface.new
  end
  
  def edit
    @collections_count = CollectionsHotspotImage.where(interface_id: @interface.id).count
    @interface_collections = []
    CollectionsHotspotImage.where(interface_id: @interface.id).each do |collection_hotspot_image|
      @interface_collections.push(ShopifyAPI::CustomCollection.find(collection_hotspot_image.collection_id))
    end
  end
  
  def create
    @interface = Interface.new(interface_params)
    @interface.collections_limit_count = 5 if @interface.collections_limit_count.nil?
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
    params.require("interface").permit(:title, :collections_limit_count)
  end
  
  def set_interface
    @interface = Interface.find(params[:id])
  end
end
