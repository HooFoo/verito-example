module ApplicationHelper
  def iterate_yaml(yml, path = '')
    pairs = []

    #skip root element
    if path == ''
      root = yml.keys.first
      yml = yml[root]
    end

    yml.each_pair do |k,v|
      if v.is_a?(Hash)
        pairs += iterate_yaml v, path==''?k:"#{path}.#{k}"
      else
        pairs << { key: "#{path}.#{k}" , value: v }
      end
    end
    pairs
  end

  def show_money_value(item, currency)
    "#{humanized_money item.main_price.value.exchange_to(currency.code)}"
  end

  def show_amount(amount, currency)
    "#{humanized_money Money.from_amount(amount,currency.code)}"
  end

  def show_money_with_symbol(item, currency)
    "#{humanized_money_with_symbol item.main_price.value.exchange_to(currency.code)}"
  end

  def show_price_with_symbol(price, currency)
    "#{humanized_money_with_symbol price.value.exchange_to(currency.code)}"
  end

  def show_money_with_symbol_proposal(proposal, currency)
    "#{humanized_money_with_symbol Money.new(proposal.price*100, 'RUB').exchange_to(currency.code)}"
  end
end
