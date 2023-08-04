
module AddBookInput
 

  def get_title
    title = "Enter the title of the book:"
    regex = /^[A-Za-z0-9\s]+$/
    get_validation(title, regex)
  end

  def get_author
    author = "Enter the author of the book:"
    regex = /^[A-Za-z\s]+$/
    get_validation(author,regex)
  end

  def get_genre
    genre = "Enter the genre of the book:"
    regex = /^[A-Za-z\s]+$/
    get_validation(genre,regex)
  end

  def get_year
    year = "Enter the year of the book:"
    regex = /^.*(\d{4})$/
    get_validation(year,regex)
  end

   def get_validation(printss, regex)
    count = 0
    max_attempts = 3
    loop do
      puts printss
      input = gets.chomp.strip

      while input.empty?
        puts "Alert => Input cannot be empty. Please try again."
        input = gets.chomp.strip
        count += 1

        return run if count >= max_attempts
      end

      unless regex.match?(input)
        puts "Invalid input format. Please try again."
        count += 1
        return run if count >= max_attempts
        redo
      end
     
      return input
    end
  end

  def get_valid_input(prompt, regex, error_message)
    loop do
      print prompt
      input = gets.chomp

      return "" if input.empty?

      if regex.match(input)
        return input.strip
      end

      puts error_message
    end
  end
  
end
