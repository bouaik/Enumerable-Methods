module Enumerable
  def my_each
    return to_enum unless block_given?

    0.upto(length - 1) do |i|
      yield self[i]
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    0.upto(length - 1) do |i|
      yield(self[i], i)
    end
    self
  end

  def my_select
    array = []
    return to_enum unless block_given?

    0.upto(length - 1) do |i|
      array << self[i] if yield self[i]
    end
    array
  end

  def my_all?(patt = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif patt.nil?
      my_each { |i| return false unless i }
    else
      my_each { |i| return false unless check_patt(i, patt) }
    end
    true
  end

  def my_any?(patt = nil, &block_name)
    if block_given?
      my_each { |i| return true if block_name.yield(i) }
    elsif patt.nil?
      my_each { |i| return true if i }
    else
      my_each { |i| return true if check_patt(i, patt) }
    end
    false
  end

  def my_none?(arg = nil, &block_name)
    !my_any?(arg, &block_name)
  end

  def my_count(item = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) == true }
    elsif item.nil?
      my_each { count += 1 }
    else
      my_each { |i| count += 1 if i == item }
    end
    count
  end

  def my_map(proc = nil)
    array = []
    if proc.nil?
      return to_enum(:my_map) unless block_given?

      my_each { |i| array << yield(self[i]) }
    else
      my_each { |i| array << proc.call(i) }
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

  def check_patt(idx, patt)
    if patt.is_a? Class
      idx.is_a?(patt)
    elsif patt.is_a? Regexp
      patt.match?(idx)
    end
  end
end

def multiply_els(arr)
  arr.my_inject { |a, b| a * b }
end
