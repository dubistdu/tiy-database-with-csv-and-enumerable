
require 'csv'

class Person # purpose of this class?
  attr_accessor :name, :phone_number, :address, :position, :salary, :slack_account, :github_account
end

class TIYdatabase
  def initialize
    @people = [] # instance variables hold data It's a container

    CSV.foreach("tiy_employees.csv", headers:true) do |person|
      name = person["name"]
      phone_number = person["phone"]
      address = person["address"]
      position = person["position"]
      salary = person["salary"]
      slack_account = person["slack"]
      github_account = person["github"]

      add_to_tiy_database(name, phone_number, address, position,salary, slack_account, github_account)
    end
  end

  def save_inventory
    csv = CSV.open("tiy_employees.csv", "w")
    csv.add_row %w{name phone address position salary slack github}

    @people.each do |person|
      csv.add_row [person.name, person.phone_number, person.address, person.position, person.salary, person.slack_account, person.github_account]
    end
    csv.close
  end

  # add tiy database to CSV
  def add_to_tiy_database(name, phone_number, address, position, salary, slack_account, github_account)
    person = Person.new
    person.name = name
    person.phone_number = phone_number
    person.address = address
    person.position = position
    person.salary = salary
    person.slack_account = slack_account
    person.github_account = github_account

    @people << person
  end

  def print_inventory
    @people.each do |person|
      puts "Name: #{person.name} | Phone Number:#{person.phone_number} | Address: #{person.address}| Position: #{person.position} | Salary: #{person.salary} | Slack Account: #{person.slack_account} | Github Account: #{person.github_account}"
    end
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

      puts "What is the phone number"
      person.phone_number = gets.chomp

      puts "What is the address?"
      person.address = gets.chomp

      puts "What is the position"
      person.position = gets.chomp

      puts "What is the salary?"
      person.salary = gets.chomp

      puts "What is the slack account?"
      person.slack_account = gets.chomp

      puts "What is the github_acct?"
      person.github_account = gets.chomp

      @people << person

      save_inventory
    end

  end

  def banner
    puts "-" * 50
  end

  def print_all_attr(person) # where is person coming from?? to use as a method it needs an argument for this to work
    banner
    puts person.name
    banner
    puts "Phone number: #{person.phone_number}"
    puts ""
    puts "Address: #{person.address}"
    puts ""
    puts "Position: #{person.position}"
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
        print_inventory
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
    @people.each do |person|
      print_all_attr(person)
    end
  end

  # runs the app
  def menu
    loop do
      puts "What do you want to do? (A)dd (S)earch (D)elete? (P)rint list (E)xit"
      action = gets.chomp.upcase
      case action
        when "A"
          add

        when "D"
          delete
          save_inventory

        when "S"
          search

        when "P"
          print_inventory

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
