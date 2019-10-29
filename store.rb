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
my_buys = 0
choice = -2
until choice == -1
  puts "Что хотите купить:"
  puts

  # предлагаем выбрать товары, их описание и наличие на складе 
  # и способ окончания процесса покупок
  puts collection
  puts "0. Выход"

  # выбор номера товара
  choice = STDIN.gets.to_i - 1
  chosen_product = collection.product_by_index(choice)

  # проверка на наличие товара, если товара нет, то снова выбор
  if chosen_product.amount == 0
    puts "Товар закончился. Выберете что-нибудь другое"
    next
  end

  # если выбранный товар на складе, продолжаем покупать
  if choice != - 1
    puts

    # уменьшили на единицу количество товара на складе, так как один экземпляр купили
    # цену купленного товара сложили с ранне купленным товаром
    buy = chosen_product.price.to_i
    my_buys += buy
    chosen_product.amount -= 1

    # формируем перечень покупок
    shoping_list << chosen_product
    puts "Вы выбрали: #{chosen_product}"
    puts
    puts "Всего товаров на сумму: #{buy} руб."
    puts
  end
end
puts "Вы купили:"
puts
puts shoping_list
puts
puts "С Вас - #{my_buys} руб. Спасибо за покупки!"
