require_relative 'library'
require_relative 'addbookinput'
require_relative 'book'

class Main < Library
  include AddBookInput

  def print_main_menu
    puts
    puts 'Welcome to the Library Catalog!'
    puts "\nMain Menu:\n"
    puts 'Enter 1. Add a book'
    puts 'Enter 2. Search by title'
    puts 'Enter 3. Search by author'
    puts 'Enter 4. Search by genre'
    puts 'Enter 5. Display catalog'
    puts 'Enter 6. edit book'
    puts 'Enter 7. delete_book'
    puts 'Enter 8. export_book'
    puts 'Enter 9. Exit'
  end

  def run
    while true
      print_main_menu
      # choice = get_user_choice
    print "\nPlease enter your choice:"
    choice = gets.chomp.strip
    puts 
      count = 0

      while choice.empty?
        puts 'Choice cannot be empty. Please enter (1-6)'
        choice = gets.chomp
        count += 1

        return run if count == 3
      end

      case choice.to_i
      when 1
        add_book
      when 2
        search_by_title
      when 3
        search_by_author
      when 4
        search_by_genre
      when 5
        display_catalog
      when 6
        edit_book(@catalogs)
      when 7
        delete_book
      when 8
        export_book(@catalogs)
      when 9
        puts 'Today is a reader, tomorrow a leader. -'
        puts 'Thanks & Goodbye!'
        break
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end
end

main = Main.new
main.run
