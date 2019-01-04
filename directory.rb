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

def write_save(filename = "students.csv")
  f = File.open(filename, "w") do |file| 
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:food]]
      csv_line = student_data.join(",")
      file.puts csv_line
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
    write_save
    puts "Saved To Default Save File."
  else
    write_save(answer + ".csv")
    puts "Saved To #{answer}."   
  end
end

def load_to_file (file) 
  f = file.readlines.each do |line|
  name, cohort, food = line.chomp.split(',')
  add_student(name, cohort, food)
  end
  file.close
end


def load_students(filename = "students.csv") # set default value students.csv if no arg specified
  # check if user wants to name save 
  puts "Do You Want To Load A Specific File? [Y/N]"
  answer = STDIN.gets.chomp.capitalize
  if answer == "Y" then puts "Which File Do You Want To Load?"end
  user_filename = STDIN.gets.chomp 

  # write to default save or user declared save file
  if answer == "Y"
    file = File.open(user_filename + ".csv", "r")
    load_to_file (file)
  elsif answer == "N"
    file = File.open("students.csv", "r")
    load_to_file (file)
  elsif answer == "Y" && !File.file?(user_file + ".csv")
    puts "This File Does Not Exist Yet. Loading Default Save"
    file = File.open("students.csv", "r")
    load_to_file (file)
  end
end

def try_load_students
  filename = ARGV.first # first arg from CLI
  if filename.nil? # if no file specified load from students.csv
    puts "Loaded Save From Default File"
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