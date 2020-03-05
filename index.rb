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

      my_each { |i| array << yield(i) }
    else
      my_each { |i| array << proc.call(i) }
    end
    array
  end

  def my_inject(total = nil, sym = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity:
    if block_given? && total.nil?
      initial = to_a[0]
      each_with_index do |e, i|
        next if i.zero?

        initial = yield(initial, e)
        total = initial
      end
    elsif (total.is_a? Numeric) && block_given?
      each { |e| total = yield(total, e) }
    elsif (total.is_a? Symbol) && !block_given?
      return operator_eval(total)
    elsif (total.is_a? Numeric) && (sym.is_a? Symbol) && !block_given?
      return operator_eval(total, sym)
    else
      raise 'no block given'
    end
    total
  end
  # rubocop:enable:

  def add_it(initial)
    sum = initial
    each { |e| sum += e }
    sum
  end

  def subtract_it(_initial)
    minus = to_a[0]
    each_with_index do |e, i|
      next if i.zero?

      minus -= e
    end
    minus
  end

  def divide_it(initial)
    divide = initial
    each_with_index do |e, i|
      next if i.zero?

      divide /= e
    end
    divide
  end

  def multiply_it(initial, total)
    multip = 1
    multip *= initial if total.is_a? Numeric
    each { |e| multip *= e }
    multip
  end

  def operator_eval(total = nil, sym = nil)
    if total.is_a? Symbol
      operator = total
      initial = 0
    else
      operator = sym
      initial = total
    end
    case operator
    when :+
      add_it(initial)
    when :-
      subtract_it(initial)
    when :/
      divide_it(initial)
    when :*
      multiply_it(initial, total)
    else
      raise "undefined method `#{operator}' for 1:Integer"
    end
  end

  def check_patt(idx, patt)
    if patt.is_a? Class
      idx.is_a?(patt)
    elsif patt.is_a? Regexp
      patt.match?(idx)
    else
      patt == idx
    end
  end
end

def multiply_els(arr)
  arr.my_inject { |a, b| a * b }
end
p [1].my_none?(1) == [1].none?(1)
