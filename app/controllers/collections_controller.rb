class CollectionsController < AuthenticatedController
  def index
    @collections = ShopifyAPI::CustomCollection.all.to_a
    #@collections += ShopifyAPI::SmartCollection.all.to_a
  end 
  
  def new
    @collection = ShopifyAPI::CustomCollection.new
  end
  
  def edit
    #collection_type = params[:collection_type]
    #if collection_type == "ShopifyAPI::CustomCollection"
      @collection = ShopifyAPI::CustomCollection.find(params[:id])
    @collection_products = @collection.products
    #else
    #  @collection = ShopifyAPI::SmartCollection.find(params[:id])
    #end
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
    
    #collection_type = params[:collection_type]
    #if collection_type == "ShopifyAPI::CustomCollection"
    @collection = ShopifyAPI::CustomCollection.find(params[:id])
    #else
    #  @collection = ShopifyAPI::SmartCollection.find(params[:id])
    #end
    
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
  
  
  private

    def collection_params
      params.permit(:body_html, :title)
    end
end
