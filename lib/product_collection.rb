# encoding: utf-8
#
# Класс КоллекцияПродуктов, который может считывать все нужные продукты из
# подкатегорий films, books и т.д.
class ProductCollection
  # Создадим константу со всеми возможными типами продуктов. Это ассоциативный
  # массив, где ключем является символ, а значением — другой ассоцаитивный
  # массив с название папки (где лежат файлы этого типа) и ссылкой на класс.
  PRODUCT_TYPES = {
    film: {dir: 'films', class: Film},
    book: {dir: 'books', class: Book},
    disk: {dir: 'disks', class: Disk}
  }

  # Конструктор коллекции принимает на вход массив продуктов, но если ничего не
  # передали на вход, то он записывает в переменную экземпляра @products пустой
  # массив.
  def initialize(products = [])
    @products = products
  end

  # Метод класса (статический метод) from_dir считывает из указанной в
  # параметрах папки все файлы:
  #
  # фильмы — из dir_path + '/films';
  # книги — из dir_path + '/books'.
  def self.from_dir(dir_path)
    # Создаем пустой массив, куда будем складывать все найденные продукты
    products = []

    # Пройдемся по каждой паре ключ-значение из константы PRODUCT_TYPES и
    # поочередно запишем эту пару соответственно в переменные type и hash.
    #
    # Сначала в type будет :film, а в hash — {dir: 'films', class: Film}, потом
    # в type будет :book, а в hash — {dir: 'books', class: Book}
    #
    PRODUCT_TYPES.each do |type, hash|
      # Получим из хэша путь к директории с файлами нужного типа, например,
      # строку 'films'
      product_dir = hash[:dir]

      # Получим из хэша объект нужного класса, например класс Film. Обратите
      # внимание, мы оперируем сейчас классом, как объектом. Передаем его по
      # ссылки и вызываем у него методы. Такова природа руби: все — объекты.
      product_class = hash[:class]

      # Для каждого текстового файла из директории, например '/data/films/'
      # берем путь к файлу и передаем его в метод класса from_file, вызывая его
      # у объекта нужного класса.
      # Dir[dir_path + '/' + product_dir + '/*.txt'] собирает в массив имена
      # всех txt файлов из директории /data/product_dir (../data/books/01.txt)
      # product_class.from(path) (Book.from_file(path))
      Dir[dir_path + '/' + product_dir + '/*.txt'].each do |path|
        products << product_class.from_file(path)
      end
    end

    # Вызываем конструктор этого же класса (ProductCollection) и передаем ему
    # заполненный массив продуктов
    # определение конструкции self.new()
    self.new(products)
  end

  # Простой метод, чтобы достать все продукты коллекции
  def to_a
    @products
  end

  # Метод sort! меняет экземпляр класса ProductCollection (меняет порядок)
  # продуктов в коллекции, поэтому он назвал с восклицательным знаком. Этот
  # метод принимает на вход ассоциативный массив, в котором могут быть два
  # ключа: :by и :order. Например, чтобы отсортировать продукты по возрастанию
  # цены, можно вызвать этот метод так:
  #
  # collection.sort!(by: :price, order: :asc)
  def sort!(params)
    # Делает выбор по параметру by
    case params[:by]
    when :title
      # Если запросили сортировку по наименованию
      @products.sort_by! { |product| product.to_s }
    when :price
      # Если запросили сортировку по цене
      @products.sort_by! { |product| product.price }
    when :amount
      # Если запросили сортировку по количеству
      @products.sort_by! { |product| product.amount }
    end

    # Если запросили сортировку по возрастанию
    @products.reverse! if params[:order] == :asc

    # Возвращаем ссылку на экземпляр, чтобы у него по цепочке можно было вызвать
    # другие методы.
    # ???
    self
  end

  # возвращаем количество товара, уменьшенное на 1
  def get_new_amount(param)
    @products[param].amount = @products[param].amount - 1
  end

  def to_s
    @products.map.with_index(1) {|product, i|"#{i}. #{product}"}.join("\n")
  end

  def product_by_index(choice)
    @products[choice]
  end
end
