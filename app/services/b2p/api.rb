require 'digest/md5'
require 'base64'
require 'rest-client'

class B2p::Api

  def self.register(opts={})
    order = [:sector, :client_ref, :first_name,
             :patronymic, :last_name, :birth_date, :inn, :snils, :persondoc_number,
             :persondoc_issdate, :persondoc_issby, :address, :email]
    hash = do_request(opts, order, 'b2puser/Register')
  end

  def self.info(opts={})
    order = [:sector, :client_ref, :signature]
    hash = do_request(opts, order, 'b2puser/Info')
  end

  def self.modify(opts={})
    order = [:sector, :client_ref, :first_name,
             :patronymic, :last_name, :birth_date, :inn, :snils, :persondoc_number,
             :persondoc_issdate, :persondoc_issby, :address, :email]
    hash = do_request(opts, order, 'b2puser/Modify')
  end

  def self.set_phone_url(opts={})
    order = [:sector, :client_ref]
    sig = create_signature(opts,order)
    url = create_url_params(opts, sig)
    uri = "#{ENV['B2P_URL']}#{'b2puser/SetPhone'}#{url}"
  end

  def self.pay_in_debit_url(opts={})
    order = [:sector, :from_client_ref,
        :to_client_ref, :amount, :currency, :token, :password]
    sig = create_signature(opts,order)
    url = create_url_params(opts, sig)
    uri = "#{ENV['B2P_URL']}#{'b2puser/PayInDebit'}#{url}"
  end

  def self.pay_out_url(opts={})
    order = [:sector, :from_client_ref,
             :to_client_ref, :amount, :currency, :token]
    sig = create_signature(opts,order)
    url = create_url_params(opts, sig)
    uri = "#{ENV['B2P_URL']}#{'b2puser/PayOut'}#{url}"
  end

  def self.card_enroll_url(opts={})
    order = [:client_ref]
    sig = create_signature(opts,order)
    url = create_url_params(opts, sig)
    uri = "#{ENV['B2P_URL']}#{'b2puser/CardEnroll'}#{url}"
  end

  def self.pay_in_fee(opts={})
    hash = do_request(opts, [], 'b2puser/PayInFee')
  end

  def self.pay_out_fee(opts={})
    hash = do_request(opts, [], 'b2puser/PayOutFee')
  end

  def self.transfer_fee(opts={})
    hash = do_request(opts, [], 'b2puser/TransferFee')
  end

  def self.complete(opts={})
    order = [:sector, :id, :amount, :currency,
             :client_ref]
    hash = do_request(opts, order, 'b2puser/Complete')
  end

  def self.reverse(opts={})
    order = [:sector, :id, :amount]
    hash = do_request(opts, order, 'b2puser/Reverse')
  end

  def self.transfer(opts={})
    order = [:sector, :from_client_ref,
             :to_client_ref, :amount, :currency]
    hash = do_request(opts, order, 'b2puser/Transfer')
  end

  def self.get_balance(opts={})
    order = [:sector, :client_ref]
    hash = do_request(opts, order, 'b2puser/GetBalance')
  end

  def self.webapi_register(opts={})
    order = [:sector, :amount, :currency]
    hash = do_request(opts, order, 'Register')
  end

  def self.webapi_user_authorize(opts={})
    order = [:sector, :id, :client_ref]
    hash = do_request(opts, order, 'UserAuthorize')
  end

  def self.webapi_user_purchase(opts={})
    order = [:sector, :id, :client_ref]
    hash = do_request(opts, order, 'UserPurchase')
  end

  def self.webapi_reverse(opts={})
    order = [:sector, :id, :amount, :currency]
    hash = do_request(opts, order, 'Reverse')
  end

  def self.sig(strings=[])
    strs = strings.join('')
    string = ENV['B2P_SECTOR'] + strs + ENV['B2P_SECRET']
    md5 = Digest::MD5.hexdigest(string)
    Base64.encode64(md5).squish
  end

  private

  def self.create_signature(opts={}, order=[])
    if order.size > 0
      string = ENV['B2P_SECTOR']
      order.each do |key|
        unless opts[key].nil?
          string += opts[key].to_s
        end
      end
      string += ENV['B2P_SECRET']
      md5 = Digest::MD5.hexdigest(string)
      Base64.encode64(md5).squish
    else
      ''
    end
  end

  def self.create_url_params(opts, signature='')
    string = '?'
    keys = opts.keys
    keys.each_with_index do |key, index|
      unless opts[key].blank?
       string += "#{key}=#{Rack::Utils.escape(opts[key])}"
       string += "&" if index < (keys.size - 1)
      end
    end
    string += "&sector=#{ENV['B2P_SECTOR']}"
    unless signature.blank?
      string += "&signature=#{Rack::Utils.escape(signature)}"
    end
  end

  def self.do_request(opts, order, endpoint)
    sig = create_signature(opts,order)
    url = create_url_params(opts, sig)
    uri = "#{ENV['B2P_URL']}#{endpoint}#{url}"
    response = RestClient::Request.execute method: :get, url: uri, timeout: 10, headers: {:accept => :xml}
    Hash.from_xml response.body
  end
end
