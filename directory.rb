def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = Array.new
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do 
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from user
    name = gets.chomp
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
  puts "Do you want to see all students or only those starting with a specific letter?"
  answer = gets.chomp

  if answer != "all"
  	puts "What's the first letter of students you want to see?"
    first_letter = gets.chomp
    students.map { |student| if student[:name].split("")[0] == first_letter then puts "#{student[:name]} is in the #{student[:cohort]} cohort" end}

  else
    students.each_with_index { |student, index| 
    puts "#{index+1}. #{student[:name]} is in the #{student[:cohort]} cohort!"}

  end
end

def print_footer(students) 
  puts "Overall we have #{students.count} epic students!"
end

print_header
print(students)
print_footer(students)