module Enumerable
  def my_each
    if block_given?
      0.upto(length - 1) do |i|
        yield self[i]
      end
    else
      puts 'no block is given'
    end
    self
  end

  def my_each_with_index
    if block_given?
      0.upto(length - 1) do |i|
        yield(self[i], i)
      end
    else
      puts 'no block is given'
    end
    self
  end

  def my_select
    array = []
    if block_given?
      0.upto(length - 1) do |i|
        array << self[i] if yield self[i]
      end
    else
      puts 'no block is given'
    end
    array
  end
end

x = [1, 5, -4, 3, 89, 11, -35]

puts '<------ MY EACH ------>'
x.my_each do |ele|
  puts ele * ele
end
puts

puts '<------ MY EACH WITH INDEX ------>'
x.my_each_with_index do |ele, index|
  puts ele * index
end
puts

puts '<------ MY SELECT ------>'
print x.my_select(&:positive?)
puts
