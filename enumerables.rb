module Enumerable
  def my_each(&block)
    return to_enum(:my_each) unless block_given?

    to_a.each(&block)
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    (0...to_a.length).each do |i|
      yield(to_a[i], i)
    end
    self
  end

  def my_select
    return to_enum(:my_each) unless block_given?

    my_array = []
    my_each do |item|
      my_array.push(item) if yield(i)
    end
    my_array
  end

  def my_all?(*arg)
    result = true
    if !arg[0].nil?
      my_each do |item|
        result = false unless arg[0] === item
      end

    elsif !block_given?
      result = true
      my_each do |item|
        result = false unless item
      end
    else
      result = true
      my_each do |item|
        result = false unless yield(item)
      end
    end
    result
  end

  def my_any?(*arg)
    result = false
    if !arg[0].nil?
      my_each do |item|
        result = true if arg[0] === item
      end
    elsif !block_given?
      result = false
      my_each do |item|
        result = true if item
      end
    else
      result = false
      my_each do |item|
        result = true if yield(item)
      end
    end
    result
  end

  def my_none?(*arg)
    result = true
    if !arg[0].nil?
      my_each do |item|
        result = false if arg[0] === item
      end

    elsif !block_given?
      result = true
      my_each do |item|
        result = false if item
      end

    else
      result = true
      my_each do |item|
        result = false if yield(item)
      end
    end
    result
  end

  def my_count(arg = nil)
    match = 0
    if arg
      my_each do |item|
        match += 1 if item == arg
      end

    elsif block_given?
      my_each do |item|
        match += 1 if yield item
      end

    else
      match = length
    end

    match
  end

  def my_map(proc = nil)
    new_arr = []
    if proc
      my_each do |item|
        new_arr.push(proc.call(item))
      end
    else
      my_each do |item|
        new_arr.push(yield item)
      end
    end
    new_arr
  end

  def my_inject(acc_value = nil, symbol = nil)
    if (!acc_value.nil? && symbol.nil?) && (acc_value.is_a?(symbol) || acc_value.is_a?(string))
      symbol = acc_value
      acc_value = nil
    end
    if !block_given? && !symbol.nil?
      my_each { |i| acc_value = acc_value.nil? ? i : acc_value.send(symbol, i) }
    else
      my_each { |i| acc_value = acc_value.nil? ? i : yield(acc_value, i) }
    end
    acc_value
  end

  def multiply_els(arr)
    arr.my_inject(1, '*')
  end
end
