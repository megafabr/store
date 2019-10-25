# encoding: utf-8
#
# Программа-магазин книг, фильмов и дисков.
# В котором пользователь может выбрать несколько товаров и программа
# напишет ему, сколько с него денег:
#
# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/film'
require_relative 'lib/disk'
require_relative 'lib/product_collection'

# Создаем коллекцию продуктов)
collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')

# Начинаем торговать
shoping_list = []
buys = 0
choice = -1
until choice == 0
  puts "Что хотите купить:"
  puts

  # предлагаем выбрать товары, их описание и наличие на складе
  collection.to_a.each_with_index {|product, i| puts "#{i+1}. #{product}"}
  puts "0. Выход"

  # если товар отсутствует
  buy_amount = 1
  while buy_amount > 0
    choice = STDIN.gets.to_i
    buy_amount = collection.get_amount(choice-1)
    if buy_amount == 0
      buy_amount = 1
      puts "Товар закончился. Выберете что-нибудь другое"
    else
      buy_amount = 0
    end
  end

  # если товар на складе продолжаем покупать
  if choice != 0
    puts

    # уменьшили на единицу количество на складе, так как один экземпляр купили
    collection.get_new_amount(choice-1)

    # цену купленного товара сложили с ранне купленным товаром
    buy = collection.get_price(choice-1).to_i
    buys += buy

    # формируем перечень покупок
    shoping_list << collection.to_a[choice-1]
    puts "Вы выбрали: #{collection.to_a[choice-1]}"
    puts
    puts "Всего товаров на сумму: #{buy} руб."
    puts
  else
    puts "Вы купили:"
    puts
    puts shoping_list
    puts
    puts "С Вас - #{buys} руб. Спасибо за покупки!"
  end
end