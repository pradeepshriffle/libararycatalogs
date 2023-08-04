require 'csv'
require_relative 'book'
require_relative 'addbookinput'
require 'date'

class Library

  include AddBookInput

  def initialize
    @catalogs = []
  end


  def add_book
    title = get_title

    if @catalogs.any? { |book| book.title == title }
      puts " Alert => The book #{title} is already present in the catalog. Please enter a different title."
       
       return add_book
    else

      author = get_author
      genre = get_genre
      year_published = get_year

      year_published = year_published.to_i
      @current_year = Date.today.year

      while year_published > @current_year
        puts 'Alert =>Please enter a valid year. The year cannot be greater than the current year.'
        year_published = get_year.to_i
        
      end

      count_author = @catalogs.count { |book| book.author == author }
      count_genre = @catalogs.count { |book| book.genre == genre }

      book = Book.new(title, author, genre, year_published)
      @catalogs << book
      puts 'Book added successfully!'

      puts "The author '#{author}' now has #{count_author + 1} book in the catalog." if count_author > 0
      puts "There are now #{count_genre + 1} book in the catalog with the genre '#{genre}'." if count_genre > 0

    end

  end


  def search_by_title
    puts 'Enter the title to search for:'
    @input = gets.chomp.downcase

    # @matched_books=@catalogs.select do  |book|
    #   book.title.downcase.start_with?(@input)
    @matched_books = @catalogs.select { |book| book.title.downcase.include?(@input) }
    search_catalogs(@input)
  end


  def search_by_author
    print 'Enter the author to search for: '
    @input = gets.chomp.downcase
    @matched_books = @catalogs.select { |book| book.author.downcase.include?(@input) }
    search_catalogs(@input)
  end


  def search_by_genre
    print 'Enter the genre to search for: '
    @input = gets.chomp.downcase
    @matched_books = @catalogs.select { |book| book.genre.downcase.include?(@input) }
    search_catalogs(@input)
  end



  def search_catalogs(input)
    if @matched_books.empty?
      puts "No books found with the genre '#{input}'."
    else
      puts "Books with the  '#{input}':"
      puts "Title\t\t\tAuthor\t\t\tGenre\t\t\tYear Published"
      puts '-----------------------------------------------------------------------------------'

      @matched_books.each do |book|
        puts "#{book.title}\t\t\t#{book.author}\t\t\t#{book.genre}\t\t\t#{book.year_published}"
      end
    end
  end


  def display_catalog
    if @catalogs.empty?
      puts 'No matching books found.'
    else
      puts 'Catalog:'
      puts "Index\t\tTitle\t\tAuthor\t\tGenre\t\tYear Published"
      puts '----------------------------------------------------------------------------------------'

      # @catalogs.each { |book| puts "#{book.title}\t\t\t#{book.author}\t\t\t#{book.genre}\t\t\t#{book.year_published}" }
      @catalogs.each_with_index do |book, index|
        puts "#{index + 1}\t\t#{book.title}\t\t#{book.author}\t\t#{book.genre}\t\t\t#{book.year_published}"
      end
    end
  end


  def delete_book
    puts 'Enter the title of the book which you want to delete'
    title = gets.chomp.downcase
    delete_book = @catalogs.select { |book| book.title.downcase == title }
    if delete_book.empty?
      puts "the book with this  #{title} is not available in our Library catalogs"
    else
      delete_book.each do |book|
        @catalogs.delete(book)
        puts "Book #{book.title} by #{book.author} deleted successfully!"
      end
    end
  end



  def edit_book(catalogs)
    puts 'Enter the title of the book you want to update!'
    title = get_valid_input('Title: ', /^[A-Za-z0-9\s]*$/,"Invalid title. .\n\n")
    title = title.downcase.strip

    updatebook = catalogs.select { |book| book.title.downcase == title }

    if updatebook.empty?
      puts "The book with the title '#{title}' is not available in our Library catalogs."
    else

     puts 'Current details of the book:'

      updatebook.each do |book|
        puts "Title: #{book.title}"
        puts "Author: #{book.author}"
        puts "Genre: #{book.genre}"
        puts "Year: #{book.year_published}"
        puts '-' * 30
      end

      new_title = get_valid_input('Enter the new Title of the book (leave blank to keep current title): ',/^[A-Za-z0-9\s]*$/, "Invalid title. \n\n")
      new_author = get_valid_input('Enter the new Author of the book (leave blank to keep current author): ', /^[A-Za-z\s]*$/, "Invalid author..\n\n")
      new_genre = get_valid_input('Enter the new Genre of the book (leave blank to keep current genre): ',/^[A-Za-z\s]*$/, "Invalid genre..\n\n")
      new_year = get_valid_input('Enter the new Year of the book (leave blank to keep current year): ', /^\d{1,4}$/,   "Invalid year. .\n\n")
      
      if(new_year.to_i>@current_year)
       puts "year cant greater than current year"
       puts "Book updated unsuccessfully!"
       return
      end
      updatebook.each do |book|

        book.title = new_title unless new_title.empty?

        book.author = new_author unless new_author.empty?

        book.genre = new_genre unless new_genre.empty?

        book.year_published = new_year unless new_year.empty?

      end
      puts 'Book updated successfully!'
        
    end

  end

  def export_book(catalogs)
    header = File.exist?('catalogs.csv')
    CSV.open('catalogs.csv', 'a+') do |csv|
      csv << %w['Title' 'Author' 'Genre' 'Year'] unless header

      catalogs.each do |catalog|
        csv << [catalog.title, catalog.author, catalog.genre, catalog.year_published]
      end
    end
    puts 'catlogs   exported successfully!'
  end

end

