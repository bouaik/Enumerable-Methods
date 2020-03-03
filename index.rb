module Enumerable # rubocop:disable Metrics/ModuleLength
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

  def my_any
    value = false
    if block_given?
      0.upto(length - 1) do |i|
        if yield self[i]
          value = true
          break
        end
      end
    else
      puts 'no block is given'
    end
    value
  end

  def my_count
    count = 0
    if block_given?
      0.upto(length - 1) do |i|
        count += 1 if yield self[i]
      end
    else
      puts 'no block is given'
    end
    count
  end

  def my_map(proc = nil)
    array = []
    if proc.nil?
      if block_given?
        0.upto(length - 1) do |i|
          array << yield(self[i])
        end
      else
        puts 'no block is given'
      end
    else
      0.upto(length - 1) do |i|
        array << proc.call(i)
      end
    end
    array
  end

  def my_inject(acc = nil)
    if acc.nil?
      acc = self[0]
      index = 1
    else
      index = 0
    end
    if block_given?
      index.upto(length - 1) do |i|
        acc = yield(acc, self[i])
      end
    else
      puts 'no block is given'
    end
    acc
  end
end

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
def multiply_els(arr)
  arr.my_inject { |a, b| a * b }
end

multiply_els([2, 4, 5])
