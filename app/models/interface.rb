class Interface < ActiveRecord::Base
  has_many :hotspot_images, dependent: :nullify
end
