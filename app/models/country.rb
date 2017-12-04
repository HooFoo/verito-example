class Country < ApplicationRecord
  has_many :city
  has_many :lang
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true,
            format: { with: /\A[A-Z]{2,3}$\z/, message: I18n::t('errors.messages.country.code')}
end
