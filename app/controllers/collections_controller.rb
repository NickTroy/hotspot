class CollectionsController < AuthenticatedController
  require 'base64'
  skip_before_action :verify_authenticity_token
  def index
    @collections = ShopifyAPI::CustomCollection.all
    @interfaces = Interface.all
    @hotspot_images = HotspotImage.all
  end 
  
  def new
    @collection = ShopifyAPI::CustomCollection.new
  end
  
  def edit
    @collection = ShopifyAPI::CustomCollection.find(params[:id])
    @interfaces = Interface.all
    @interfaces_and_hotspot_images =  HotspotImage.select("hotspot_images.id as hotspot_image_id, hotspot_images.title as hotspot_image_title, interfaces.id as interface_id, interfaces.title as interface_title")
                                                  .joins("inner join collections_hotspot_images on collections_hotspot_images.collection_id = #{ @collection.id } and hotspot_images.id = collections_hotspot_images.hotspot_image_id")
                                                  .joins("right join interfaces on collections_hotspot_images.interface_id = interfaces.id").uniq
    @all_hotspot_images = HotspotImage.all
    @collection_products = @collection.products
    @product_builder_collection = ShopifyAPI::SmartCollection.where(:title => "Product_builder_products")[0]
    @all_products = ShopifyAPI::Product.find(:all, :params => { :limit => 250, :collection_id => @product_builder_collection.id})
    begin 
      @collection_image_src = @collection.image.src
    rescue
      @collection_image_src = ""
    end
  end
  
  def create
    if params[:commit] == 'Back to all collections'
      redirect_to root_url(:protocol => 'https')
      return true
    end
    
    @collection = ShopifyAPI::CustomCollection.new(collection_params)
    if @collection.save
      redirect_to root_url(:protocol => 'https')
    end
  end
  
  def update
    if params[:commit] == 'Back to all collections'
      redirect_to root_url(:protocol => 'https')
      return true
    end
    
    @collection = ShopifyAPI::CustomCollection.find(params[:id])
    @collection_products = @collection.products

    respond_to do |format|
      format.html do 
        if @collection.update_attributes(collection_params)
          redirect_to root_url(:protocol => 'https')
        end
      end
    end
  end
  
  def destroy
    @collection = ShopifyAPI::CustomCollection.find(params[:id])
    if @collection.destroy
      redirect_to root_url(:protocol => 'https')
    end
  end
  
  def unassign_product
    @collect = ShopifyAPI::Collect.where(product_id: params[:product_id], collection_id: params[:collection_id])[0]
    if @collect.destroy
      render json: { message: "unassigned" }, status: 200
    end
  end
  
  def assign_product
    @collect = ShopifyAPI::Collect.new(product_id: params[:product_id], collection_id: params[:collection_id])
    @product = ShopifyAPI::Product.find(params[:product_id])
    @product_image_source = ""
    unless @product.image.nil?
      @product_image_source = @product.image.src
    end
    if @collect.save
      render json: { product_title: @product.title, product_image_src: @product_image_src }, status: 200
    else
      render json: { message: "failed" }, status: 500
    end
  end
  
  def assign_hotspot_image
    @interface = Interface.find(params[:interface_id])
    current_collections_count = CollectionsHotspotImage.where(interface_id: @interface.id).count
    if @interface.collections_limit_count == current_collections_count 
      render json: { message: "Can't assign image to this interface because collections limit(#{ @interface.collections_limit_count }) in this interface was reached" }, status: 500
      return
    end
    @hotspot_image = HotspotImage.find(params[:hotspot_image_id])
    @collection = ShopifyAPI::CustomCollection.find(params[:collection_id])
    @collection_hotspot_image = CollectionsHotspotImage.find_by(collection_id: @collection.id, hotspot_image_id: @hotspot_image.id) || CollectionsHotspotImage.create(collection_id: @collection.id, hotspot_image_id: @hotspot_image.id)
    if @collection_hotspot_image.update_attributes(interface_id: @interface.id)
      render json: { message: "assigned" }, status: 200
    else 
      render json: { message: "failed" }, status: 500
    end
  end
  
  def delete_image
    @collection = ShopifyAPI::CustomCollection.find(params[:collection_id])
    if @collection.update_attributes(:image => "")
      render json: { message: "deleted" }, status: 200
    else
      render json: { message: "failed" }, status: 500
    end
  end
  
  def update_collection_image
    @collection = ShopifyAPI::CustomCollection.find(params[:collection_id])
    attachment = attachment = Base64.encode64(params[:image].tempfile.read)
    if @collection.update_attributes(image: { attachment: attachment })
      render json: { message: "unassigned" }, status: 200
    else
      render json: { message: "failed" }, status: 500
    end
  end
  
  private

    def collection_params
      params.permit(:body_html, :title)
    end
end
