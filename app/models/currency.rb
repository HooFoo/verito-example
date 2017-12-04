class Currency < ApplicationRecord
  belongs_to :country
  has_many :profiles
  has_many :prices

  mount_uploader :icon, CurrencyIconUploader

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
