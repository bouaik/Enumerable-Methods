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

  def my_all
    value = true
    if block_given?
      0.upto(length - 1) do |i|
        value = false unless yield self[i]
      end
    else
      puts 'no block is given'
    end
    value
  end

  def my_none
    value = false
    if block_given?
      0.upto(length - 1) do |i|
        value = true unless yield self[i]
      end
    else
      puts 'no block is given'
    end
    value
  end
end

x = [1, 5, -4, 3, 89, 11, -35]
words = %w[bacon orang apple]

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
