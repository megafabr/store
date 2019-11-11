lass Cart
def initialize
  @products = []
end

  def next_choice_to_cart(chosen_product)
    @purchase_price = chosen_product.price
    @products << chosen_product
  end

  def total_sum
    @products.sum(&:price)
  end

  def to_s
    <<~TEXT
      Вы купили:
      #{@products.join("\n      ")}
    
      С Вас - #{total_sum} руб. Спасибо за покупки!
    TEXT
  end
end
