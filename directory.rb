require "CSV"

# instance var for use across all methods
@students = []

# more efficient method calls
def add_student(name, cohort, food)
  @students << {name: name, cohort: cohort.to_sym, food: food}
end

# allows input of students
def input_students
  puts "Please enter the names of the students"

  # get the first name
  name = STDIN.gets.chomp.capitalize
    # exit CLI if no input
    if name.empty? then exit end

  # while the name is not empty, repeat this code
  puts "What cohort will #{name} be in?"

  # ask for cohort, turn to sym 
  cohort = STDIN.gets.chomp.capitalize.to_sym
    # if input empty > cohort TBD
    if cohort.empty? then cohort = :TBD end
  
  # ask for food
  puts "What's #{name}'s favorite food?"
  food = STDIN.gets.chomp.capitalize.rjust(15)
  
  while !name.empty? do 

    # add the student hash to the array
    add_student(name, cohort, food)
    
    if @students.length == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.length} students"
    end

    puts "Which other students will attend Villains Academy?"
    name = STDIN.gets.chomp.capitalize
      # break loop if no input
      if name.empty? then break end

    puts "What cohort will #{name} be in?"
    cohort = STDIN.gets.chomp.capitalize.to_sym
      if cohort.empty? then cohort = :TBD end
    puts "What's #{name}'s favorite food?"
    food = STDIN.gets.chomp.capitalize.rjust(15)
    end
end

def print_header 
  puts "The students of Villains Academy".center(15)
  puts "-------------".center(30)
end

def print_student_list
  # create new array for output sorted by cohort
  cohort_list = Array.new
  puts "Which cohort do you want to see?"
  answer_cohort = gets.chomp.capitalize.to_sym
  
  @students.map{ |x| if x[:cohort] == answer_cohort then cohort_list << x end}
  cohort_list.map {|student| puts "#{student[:name]} loves \n#{student[:food]}"}
end

def print_footer
  if @students.count == 1 
    puts "We have 1 epic student!" 
  else  
    puts "Overall we have #{@students.length} epic students!"
  end
end

# write to filing using CSV class
def csv_write (filename = "students.csv")
  CSV.open(filename, "w") do |row|
    @students.each do |student|
      row << [student[:name], student[:cohort], student[:food]]
    end
  end
end

def save_students
  # check if user wants to name save 
  puts "If You Want To Name Your Save File, Enter Your Name. Else Just Hit Return."
  answer = STDIN.gets.chomp
  
  # write to default save or user declared save file
  if answer.empty? 
    # if user wants to name savefile, pass input to write_save
    csv_write
    puts "Saved To Default Save File."
  else
    csv_write(answer + ".csv")
    puts "Saved To #{answer}."   
  end
end

# read from file using CSV class
def load_file (filename = "students.csv")
  CSV.foreach(filename) do |row|
    name, cohort, food = row.map{ |element| element.chomp}
    add_student(name, cohort, food)
  end
end

def load_students(filename = "students.csv") # set default value students.csv if no arg specified
  # check if user wants to name save 
  puts "Which File Do You Want To Load? Hit Enter For Default."
  answer = STDIN.gets.chomp.capitalize

  # write to user declared save file
  if !answer.empty? && File.file?(answer + ".csv")
    load_file (answer + ".csv")
  # load default
  elsif answer.empty?
    load_file
  # wrong file specified, load default
  else
    puts "This File Does Not Exist. Loading Default Save"
    load_file
  end
end

def try_load_students
  filename = ARGV.first # first arg from CLI
  if filename.nil? # if no file specified load from students.csv
    return load_students 
  end 
  if File.file?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end
end

# shows menu of user options for all program features
def print_menu
  puts "Press 1 To Input The Student"
  puts "Press 2 To Show The Students"
  puts "Press 3 To Save The List To File"
  puts "Press 4 To Load Students From Local File"
  puts "Press 9 To Exit"
end

# shows 
def show_students
  print_header
  print_student_list
  print_footer
end

# giving input feedback
def input_fb(selection)
  case selection
    when "1", "2"
      "Input Accepted"
    when "3"
      "Students Have Been Saved To File"
    when "4"
      "Students Have Been Loaded From File"
    when "9"  
      "Input Accepted\nHave A Wonderful Day"
    else
      "Please Choose A Valid Option"
  end
end

# take input from user
def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "5"
      methcheck
    when "9"
      exit
  end
  puts input_fb(selection)
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu


# refactors -> automatically create gitignores for new saves