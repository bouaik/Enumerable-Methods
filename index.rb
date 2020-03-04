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

  def my_none?(arg = nil)
    !my_all?(arg)
  end

  def my_any?(patt = nil)
    if block_given?
      my_each { |i| return true unless yield(i) }
    elsif patt.nil?
      my_each { |i| return true unless i }
    else
      my_each { |i| return true unless check_patt(i, patt) }
    end
    false
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
