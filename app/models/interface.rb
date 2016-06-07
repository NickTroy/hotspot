class Interface < ActiveRecord::Base
  has_many :collections_hotspot_images, dependent: :nullify
  validates :title, presence: true, uniqueness: true
  validate :collections_limit_count_minimum
  
  def collections_limit_count_minimum
    collections_in_this_interface = CollectionsHotspotImage.where(interface_id: self.id).count
    if self.collections_limit_count < collections_in_this_interface
      self.errors.add("Collections count limit can't be less then current collections count in this interface(#{ collections_in_this_interface })")
    end
  end
end
