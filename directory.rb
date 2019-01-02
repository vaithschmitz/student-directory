# instance var for use across all methods
@students = []

# allows input of students
def input_students
  puts "Please enter the names of the students"

  # get the first name
  name = gets.chomp.capitalize
    # exit CLI if no input
    if name.empty? then exit end

  # while the name is not empty, repeat this code
  puts "What cohort will #{name} be in?"

  # ask for cohort, turn to sym 
  cohort = gets.chomp.capitalize.to_sym
    # if input empty > cohort TBD
    if cohort.empty? then cohort = :TBD end
  
  # ask for food
  puts "What's #{name}'s favorite food?"
  food = gets.chomp.capitalize.rjust(15)
  
  while !name.empty? do 

    # add the student hash to the array
    @students << {name: name, cohort: cohort.to_sym, food: food}
    
    if @students.length == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.length} students"
    end

    puts "Which other students will attend Villains Academy?"
    
    name = gets.chomp.capitalize
      # break loop if no input
      if name.empty? then break end

    puts "What cohort will #{name} be in?"
    cohort = gets.chomp.capitalize.to_sym
      if cohort.empty? then cohort = :TBD end
    puts "What's #{name}'s favorite food?"
    food = gets.chomp.capitalize.rjust(15)
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

  puts "Do you want to see all students or only those starting with a specific letter? (Please enter all for all)"
  answer_letter = gets.chomp

  if answer_letter != "all"
    puts "What's the first letter of students you want to see?"
    first_letter = gets.chomp.capitalize
    # make global var to store students with letter based on user_input
    letter_students = []
    cohort_list.map { |student| if student[:name].split("")[0] == first_letter then letter_students << student end}
    puts letter_students.map {|student| puts "#{student[:name]} loves \n#{student[:food]}"}
  end

end

def print_footer
  if @gstudents.count == 1 
    puts "We have 1 epic student!" 
  else  
    puts "Overall we have #{@students.count} epic students!"
  end
end

# shows menu of user options for all program features
def print_menu
  puts "Press 1 To Input The Student"
  puts "Press 2 To Show The Students"
  puts "Press 9 To Exit"
end

# shows 
def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "9"
      exit
    else 
      puts "Please Enter One Of The Following Options"
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu
