class DefaultCityValidator < ActiveModel::Validator
  def validate(record)
    if record.default_city
      unless City.default_city.size == 0 || City.default_city.first == record
        record.errors[:default_city] = I18n.t('activerecord.errors.messages.only_one')
      end
    end
  end
end