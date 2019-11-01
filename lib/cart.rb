class Cart
  def initialize
    @cart = []
    @cart_price = 0
  end

  def next_choice_to_cart(chosen_product, price)
    @chosen_product = chosen_product
    @purchase_price = price
    @cart << @chosen_product
    @cart_price += @purchase_price
  end

  def to_s
    "Вы выбрали: #{@chosen_product}" + "\n\n" +
    "Всего товаров на сумму: #{@purchase_price} руб." + "\n\n"
  end

  def print_cart
    "Вы купили:" + "\n\n" + @cart.join("\n") + "\n\n" +
    "С Вас - #{@cart_price} руб. Спасибо за покупки!"
  end
end
