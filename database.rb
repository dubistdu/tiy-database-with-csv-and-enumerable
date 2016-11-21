
#require 'csv'

class Person # purpose of this class?
  attr_accessor :name, :phone_number, :address, :position, :salary, :slack_acct, :github_acct
end

class TIYdatabase
  def initialize
    @people = [] # instance variables hold data It's a container
  end

  # add a person but prevents double entry
  def add
    # NTS - def do things

    # search first before adding a new person
    puts "What is the name?"
    search_name = gets.chomp.capitalize

    found_person = @people.any? {|person| person.name.capitalize == search_name}
    if found_person == true
      puts "#{search_name} already exist! Please type different name"
    else

      person = Person.new # create person obj

      person.name = search_name

      puts "What is the position?"
      person.position = gets.chomp

      puts "What is the address?"
      person.address = gets.chomp

      puts "What is the phone number?"
      person.phone_number = gets.chomp

      puts "What is the salary?"
      person.salary = gets.chomp

      puts "What is the slack account?"
      person.slack_acct = gets.chomp

      puts "What is the github_acct?"
      person.github_acct = gets.chomp

      @people << person
    end

  end

  def banner
    puts "-" * 50
  end

  def print_all_attr(person) # where is person coming from?? to use as a method it needs an argument for this to work
    banner
    puts person.name
    banner
    puts "Position: #{person.position}"
    puts ""
    puts "Address: #{person.address}"
    puts ""
    puts "Phone number: #{person.phone_number}"
    puts ""
    puts "Salary: #{person.salary}"
    puts ""
    puts "Slack account: #{person.slack_acct}"
    puts ""
    puts "Github account: #{person.github_acct}"
    puts ""
  end

  def search
    puts "What name do you want to search?"
    search_name = gets.chomp.capitalize
    found_people = @people.find_all { |person| person.name.capitalize == search_name } # this does search and find that person
    # p found_people
    if found_people.empty?
      puts "Sorry, there is no such name"
    else
      found_people.each do |person|
        print_all_attr(person)
      end
    end
  end

  def delete
    puts "What name do you want to delete from the list"
    delete_person = gets.chomp.capitalize
    found_people = @people.select { |person| person.name.capitalize == delete_person }
    if found_people.empty?
      puts "Sorry, there is no such name"
    else
      found_people.each do |person|
        puts "Delete #{person.name}? Y/N"
        answer = gets.chomp
        if answer == ("y" || "Y")
          @people.delete(person)
          puts "#{person.name} is deleted from the list!"
        end
      end
    end
  end
  # eventually remove a person from @people

  def print_list
    puts "Here is the list"
    index = 0
    loop do
      if index >= @people.length # always need something to break the loop. It's not going to stop automatically
        break # just because you have limited number of index
        end
      person = @people[index]
      print_all_attr(person)
      index += 1
    end
  end

  def menu
    loop do
      puts "What do you want to do? (A)dd (S)earch (D)elete? (P)rint list (E)xit"
      action = gets.chomp.upcase
      case action
        when "A"
          add

        when "D"
          delete

        when "S"
          search

        when "P"
          print_list

        when "E"
          break

        else
          break

      end
    end
  end
end

database = TIYdatabase.new
database.menu
