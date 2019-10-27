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
choice = -2
until choice == -1
  puts "Что хотите купить:"
  puts

  # предлагаем выбрать товары, их описание и наличие на складе 
  # и способ окончания процесса покупок
  puts collection
  puts "0. Выход"

  # если товар отсутствует нужно сделать выбор еще разamount
  buy_amount = 1
  while buy_amount > 0
    choice = STDIN.gets.to_i - 1
    buy_amount = collection.to_a[choice].amount
    if buy_amount == 0
      buy_amount = 1
      puts "Товар закончился. Выберете что-нибудь другое"
    else
      buy_amount = 0
    end
  end

  # если выбранный товар на складе, продолжаем покупать
  if choice != - 1
    puts

    # уменьшили на единицу количество товара на складе, так как один экземпляр купили
    collection.get_new_amount(choice)

    # цену купленного товара сложили с ранне купленным товаром
    buy = collection.to_a[(choice)].price.to_i
    buys += buy

    # формируем перечень покупок
    shoping_list << collection.to_a[choice]
    puts "Вы выбрали: #{collection.to_a[choice]}"
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
