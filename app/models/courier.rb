class Courier < ApplicationRecord

  devise :database_authenticatable, :rememberable, :trackable

  belongs_to :city
  has_many :proposals
  has_many :orders

  scope :for_city, -> (city) { where(city: city) }

end
