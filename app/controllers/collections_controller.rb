class CollectionsController < AuthenticatedController
  require 'base64'
  skip_before_action :verify_authenticity_token
  def index
    @collections = ShopifyAPI::CustomCollection.all.to_a
  end 
  
  def new
    @collection = ShopifyAPI::CustomCollection.new
  end
  
  def edit
    @collection = ShopifyAPI::CustomCollection.find(params[:id])
    @collection_products = @collection.products
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
  
  def update_collection_image
    @collection = ShopifyAPI::CustomCollection.find(params[:collection_id])
    attachment = attachment = Base64.encode64(params[:image].tempfile.read)
    binding.pry
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
