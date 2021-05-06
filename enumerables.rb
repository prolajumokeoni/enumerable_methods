# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each(&block)
    return to_enum(:my_each) unless block_given?

    each(&block)
    self
  end

  def my_each_with_index
    # return to_enum(:my_each_with_index) unless block_given?
    i = 0
    while i < length
      yield i, self[i]
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    my_array = []
    my_each do |item|
      my_array.push(item) if yield(item)
    end
    my_array
  end

  # rubocop:disable Style/CaseEquality
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
      match = to_a.length
    end

    match
  end

  # rubocop:enable Style/CaseEquality
  def my_map(proc = nil)
    # rubocop:disable Lint/ToEnumArguments
    return to_enum(:my_map) unless block_given?
    # rubocop:enable Lint/ToEnumArguments

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
    arr = to_a
    if acc_value && symbol
      arr.my_each { |n| acc_value = acc_value.send(symbol, n) }
    elsif acc_value && !block_given?
      symbol = acc_value
      acc_value = arr[0]
      arr.drop(1).my_each { |n| acc_value = acc_value.send(symbol, n) }
    elsif acc_value
      arr.my_each { |n| acc_value = yield(acc_value, n) }
    else
      acc_value = arr[0]
      arr.drop(1).my_each { |n| acc_value = yield(acc_value, n) }
    end
    acc_value
  end
end
# rubocop:enable Metrics/ModuleLength

def multiply_els(arr)
  arr.my_inject(1) { |result_memo, n| result_memo * n }
end
