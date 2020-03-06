x = [1, 5, -4, 3, 89, 11, -35]
words = %w[bacon orang apple]
my_proc = proc { |ele| ele * 2 }

puts '<------ MY EACH ------>'
x.my_each do |ele|
  puts ele * ele
end

puts '<------ MY EACH WITH INDEX ------>'
x.my_each_with_index do |ele, index|
  puts ele * index
end

puts '<------ MY SELECT ------>'
print x.my_select(&:positive?)
puts

puts '<------ MY ALL ------>'
words.my_all do |str|
  str.size == 5
end
x.my_all(&:positive?)

puts '<------ MY NONE ------>'
words.my_none do |str|
  str.size == 5
end
x.my_none(&:positive?)

puts '<------ MY ANY ------>'
words.my_any do |str|
  str.size == 5
end
x.my_any(&:positive?)

puts '<------ MY COUNT ------>'
words.my_count do |str|
  str.size == 5
end
x.my_count(&:positive?)

puts '<------ MY MAP ------>'
x.my_map(my_proc)
puts
x.my_map { |ele| ele * 2 }

puts '<------ MY INJECT ------>'
x.my_inject(4) do |a, b|
  a + b
end

puts '<------ TEST MY INJECT WITH A METHOD ------>'
multiply_els([2, 4, 5])
