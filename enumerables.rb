module Enumerable
  def my_each 
    return to_enum(:my_each) unless block_given?
    for i in to_a
      yield(i)  
    end
    self
  end

  def my_each_with_index 
    return to_enum(:my_each_with_index) unless block_given?
    for i in 0...to_a.length
      yield(to_a[i],i)  
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
    if  !arg[0].nil?
      result = true
      my_each do |item|
        result = false unless arg[0] ===  item
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
end

