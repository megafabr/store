class Disk < Product
  attr_accessor :title, :performer, :genre, :year

  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
      title: lines[0],
      performer: lines[1],
      genre: lines[2],
      year: lines[3],
      price: lines[4],
      amount: lines[5]
    )
  end

  def initialize(params)
    super

    @title = params[:title]
    @performer = params[:performer]
    @genre = params[:genre]
    @year = params[:year]
  end

  def to_s
    "Альбом #{@performer} - «#{@title}», #{@genre}, #{@year}, #{super}"
  end


  def update(params)
    super

    @title = params[:title] if params[:title]
    @genre = params[:genre] if params[:genre]
    @performer = params[:performer] if params[:performer]
    @year = params[:year] if params[:year]
  end
end