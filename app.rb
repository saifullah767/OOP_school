require './book'
require './classroom'
require './person'
require './rental'
require './student'
require './teacher'

class App
  def initialize
    @persons = []
    @books = []
    @rentals = []
  end

  def list_books
    puts 'List of all books'
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
    puts ''
  end

  def list_people
    puts 'List of all people'
    @persons.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    puts ''
  end

  def input_number(text, range)
    loop do
      print text
      input = gets.chomp.to_i
      return input if range.include?(input)
    end
  end

  def get_user_person_info
    student_or_teacher = input_number('Do you want to create a student (1) or a teacher (2)? [Input a number]: ', (1..2))
    print 'Name: '
    @name = gets.chomp
    print 'Age : '
    @age = gets.chomp.to_i
  end

  def create_person
    get_user_person_info
    case student_or_teacher
    when 1
      create_student
    when 2
      create_teacher
    end
  end

  def input_letters(text, range)
    loop do
      print text
      input = gets.chomp.upcase
      return input if range.include?(input)
    end
  end

  def get_user_student_info
    permission_input = input_letters('Has parent permission? [Y/N]: ', %w[Y N])
    @permission = (@permission == 'Y')
  end

  def create_student
    get_user_student_info
    @persons << Student.new('Unkown', @age, @name, @permission)
    puts "Person created successfully \n\n"
  end

  def get_user_teacher_info
    print 'Specialization: '
    @specialization = gets.chomp
  end

  def create_teacher
    get_user_teacher_info
    @persons << Teacher.new(@specialization, @age, @name)
    puts "Person created successfully\n\n"
  end

  def create_book
    puts 'Create a book'
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts "Book created successfully\n\n"
  end

  def create_rental
    puts 'Create rental'
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
    book_number = gets.chomp.to_i
    puts 'Select a Person from the following list by number'
    @persons.each_with_index do |person, index|
      puts " #{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_number = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    @rentals << Rental.new(date, @books[book_number], @persons[person_number])
    puts "Rental created successfully \n\n"
  end

  def list_rentals
    puts 'List all rentals'
    print 'Enter ID of person: '
    person_id = gets.chomp
    puts 'Rentals : '
    @rentals.each do |rent|
      if rent.person.id.to_s == person_id.to_s
        puts "#{rent.class} #{rent.date} | Book: \"#{rent.book.title}\" rented by #{rent.person.name}"
      end
    end
  end
end
