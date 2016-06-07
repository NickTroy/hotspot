class HotspotImage < ActiveRecord::Base
  has_many :collections_hotspot_images, dependent: :destroy
  validates :title, presence: true, uniqueness: true
end
