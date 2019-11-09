class Cart
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
    <<-HTML
    С Вас - #{total_sum} руб. Спасибо за покупку!
    Вы выбрали: #{@chosen_product}

    HTML
  end

  def print_cart
    <<-HTML
    Вы купили: 
    #{@products.join("\n    ")}

    С Вас - #{total_sum} руб. Спасибо за покупки!
    HTML
  end
end
