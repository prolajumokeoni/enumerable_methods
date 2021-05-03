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
        result = true  if arg[0] === item
      end
    elsif !block_given?
      result = false
      my_each do |item|
        result = true if  item
    end
    else
      result = false
      my_each do |item|
        result = true if  yield(item)
      end
    end
    result
  end
end

p check = [].my_any?  