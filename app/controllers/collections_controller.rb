class CollectionsController < AuthenticatedController
  def index
    @collections = ShopifyAPI::CustomCollection.all.to_a
    @collections += ShopifyAPI::SmartCollection.all.to_a
  end 
end
