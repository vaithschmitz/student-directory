
#intro
puts "The students of Villains Academy"
puts "-------------"

#list of students
students = [
"Dr. Hannibal Lecter",
"Darth Vader",
"Nurse Ratched",
"Michael Corleone",
"Alex DeLarge",
"The Wicked Witch of the West",
"Terminator",
"Freddy Krueger",
"The Joker",
"Joffrey Baratheon", 
"Norman Bates"
]

#print student names
students.each { |student| puts student}

#output student count as interpolated string
puts "Overall we have #{students.count} epic students!"