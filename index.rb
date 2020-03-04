module Enumerable # rubocop:disable Metrics/ModuleLength
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

def multiply_els(arr)
  arr.my_inject { |a, b| a * b }
end
