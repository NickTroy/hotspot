class Interface < ActiveRecord::Base
  has_many :collections_hotspot_images, dependent: :nullify
  validates :title, presence: true, uniqueness: true
end
