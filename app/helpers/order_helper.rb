module OrderHelper
  def payment_delivery_options(item)
    Order::DeliveryTypes.map do |type|
      text = I18n.t("order.delivery.options.#{type}")
      if type == 'self'
        text += "#{item.city} - #{item.filial}"
      end
      [type, text]
    end
  end

  def payment_options
    Order::PaymentTypes.map do |type|
      [type, I18n.t("order.payment.options.#{type}")]
    end
  end
end
