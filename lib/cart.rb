class Cart
def initialize
  @products = []
  # @cart_price = 0
end

  def next_choice_to_cart(chosen_product)
    @chosen_product = chosen_product
    @purchase_price = chosen_product.price
    @products << chosen_product
    # @cart_price += @purchase_price
  end

  def to_s
    cart_price = @products.sum { |product| product.price.to_i }
    page = <<-HTML
    С Вас - #{cart_price} руб. Спасибо за покупку!
    Вы выбрали: #{@chosen_product}

    HTML
  end

  def print_cart
    cart_price = @products.sum { |product| product.price.to_i }
    page = <<-HTML
    Вы купили: 
    #{@products.join("\n    ")}

    С Вас - #{cart_price} руб. Спасибо за покупки!
    HTML
  end
end
