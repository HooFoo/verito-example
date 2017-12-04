module ProposalsHelper
  def delivery_options(city, item = nil)
    Proposal::DeliveryTypes.map do |type|
      text = I18n.t("proposals.delivery.#{type}")
      if type == 'self'
        if item.nil?
          [type, text, "#{city.name}, #{city.main_filial}"]
        else
          [type, text, "#{item.city.name}, #{item.filial}"]
        end
      else
        [type, text]
      end
    end
  end
end
