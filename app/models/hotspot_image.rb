class HotspotImage < ActiveRecord::Base
  has_many :collections_hotspot_images, dependent: :destroy
  belongs_to :interface
  validates :title, presence: true, uniqueness: true
end
