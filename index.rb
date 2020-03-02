module Enumerable
  puts '<------ MY EACH ------>'
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
end

x = [1, 5, -4, 3, 89, 11, -35]

x.my_each do |ele|
  puts ele * ele
end
