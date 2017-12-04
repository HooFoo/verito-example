
class IpService
  @@sypex = RestClient::Resource.new(ENV['SYPEX_URL'])

  def self.ip_city(address)
    Rails.cache.fetch("geo/city/#{address}", expires_in: 6.hours) do
      json = JSON.parse @@sypex[address].get()
      if json['city']
        json['city']['name_ru']
      else
        nil
      end
    end
  end

  def self.ip_country(address)
    Rails.cache.fetch("geo/country/#{address}", expires_in: 6.hours) do
      json = JSON.parse @@sypex[address].get()
      if json['country']
        Country.where(code: json['country']['iso']).first
      else
        nil
      end
    end
  end
end