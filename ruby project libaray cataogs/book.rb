class Book
  attr_accessor :title, :author, :genre, :year_published

  def initialize(title, author, genre, year_published)
    @title = title
    @author = author
    @genre = genre
    @year_published = year_published
  end
end


