def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = Array.new
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  puts "What's #{name}'s favorite food?"
  food = gets.chomp
  while !name.empty? do 
    # add the student hash to the array
    students << {name: name, food: food, cohort: :november}
    puts "Now we have #{students.count} students"
    puts "Who else is in the cohort?"
    name = gets.chomp 
      puts "What's #{name}'s favorite food?"
      food = gets.chomp
    end
  end
  # return the array of students
  students
end

students = input_students

def print_header 
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  puts "Do you want to see all students or only those starting with a specific letter? (Please enter all for all)"
  answer_letter = gets.chomp

  puts "What's the first letter of students you want to see?"
  first_letter = gets.chomp
    #make global var to store students with letter based on user_input
    $letter_students = []
    students.map { |student| if student[:name].split("")[0] == first_letter then $letter_students << student end}

  puts "Do you want to see all students or only short names? (Please enter all for all)"
  answer_long = gets.chomp

  # print only students with first letter based on user input
  if answer_letter != "all" && answer_long == "all"
    $letter_students.map { |student| puts "#{student[:name]} loves #{student[:food]} and is in the #{student[:cohort]} cohort!"} 
  
  # print all names but only if chars < 12
  elsif answer_letter == "all" && answer_long != "all" 
    students.map { |student| if student[:name].split("").length < 12 then puts "#{student[:name]} loves #{student[:food]} and is in the #{student[:cohort]} cohort" end}

  # print only user-inputted first letter names with chars < 12
  elsif 
    answer_letter != "all" && answer_long != "all"
    $letter_students.map { |student| if student[:name].split("").length < 12 then puts "#{student[:name]} loves #{student[:food]} and is in the #{student[:cohort]} cohort" end}

  # print all students regardless
  else
    students.each_with_index { |student, index| 
    puts "#{index+1}. #{student[:name]} loves #{student[:food]} and
     is in the #{student[:cohort]} cohort!"}

  end
end

def print_footer(students) 
  puts "Overall we have #{students.count} epic students!"
end

print_header
print(students)
print_footer(students)