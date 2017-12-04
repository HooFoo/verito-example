require 'yaml'
class Lang < ApplicationRecord
  include ApplicationHelper

  Default = 'ru'

  has_many :translations, dependent: :destroy
  belongs_to :country

  after_create :make_translations
  after_update :update_translations

  validates :code, uniqueness: true, length: {minimum: 2, maximum: 3}
  validates :file, presence: true

  mount_uploader :icon, LangIconUploader
  mount_uploader :file, TranslationsUploader

  def to_s
    "#{name}-[#{code}]"
  end

  private

  def update_translations
    self.translations.destroy_all
    make_translations
    I18n.backend.reload!
  end

  def make_translations
    translation = YAML.load_file(self.file.path)
    pairs = iterate_yaml translation
    pairs.each { |p| create_translation(p[:key], p[:value]) }
  end

  def create_translation(key, value)
    Translation.create locale: self.code, lang: self,
                       key: key, value: value,
                       interpolations: [], is_proc: false
  end
end
