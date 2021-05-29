require_relative '../enumerables'

describe Enumerable do
  let(:integer_arr) { [1, 2, 3, 4, 5] }
  let(:string_arr) { %w[apple peach mango] }
  let(:combined_arr) { [5, true, nil] }
  let(:empty_arr) { [] }

  describe '#my_each' do
    it 'iterates over every element in the array' do
      expect(integer_arr.my_each { |i| i * 2 }).to eql([1, 2, 3, 4, 5])
    end
    it 'iterates over every element in the array' do
      expect(string_arr.my_each(&:to_s)).to eql(%w[apple peach mango])
    end
    it 'returns an enumerator if no block is given' do
      expect(integer_arr.my_each).to be_a(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'iterates over every element with its index' do
      expect(integer_arr.my_each_with_index { |item, index| item if index.even? }).to eql([1, 2, 3, 4, 5])
    end
    it 'iterates over every element with its index' do
      expect(integer_arr.my_each_with_index { |item, _index| item.to_s }).to eql([1, 2, 3, 4, 5])
    end
    it 'returns an enumerator if no block is given' do
      expect(integer_arr.my_each).to be_a(Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns new array that pass condition' do
      expect(integer_arr.my_select(&:even?)).to eql([2, 4])
    end
    it 'returns new array that pass condition' do
      expect(string_arr.my_select { |item| item.length > 1 }).to eql(%w[apple peach mango])
    end
    it 'returns new array that pass rcondition' do
      expect(combined_arr.my_select { |item| !item.nil? }).to eql([5, true])
    end
    it 'returns an enumerator if no block is given' do
      expect(integer_arr.my_select).to be_a(Enumerator)
    end
  end

  describe '#my_any' do
    it 'returns true if at least one or more elements within the original array fit a condition' do
      expect(integer_arr.my_any?(5)).to eql(true)
    end
    it 'returns true if at least one or more elements within the original string array fit a condition' do
      expect(string_arr.my_any?('mang')).to eql(false)
    end
    it 'returns true if at least one or more elements within the original array fit a condition' do
      expect(combined_arr.my_any?(5)).to eql(true)
    end
    it 'returns true only if one of the collection of members is not false or nil' do
      expect(empty_arr.my_any?).to eql(false)
    end
  end

  describe '#my_all?' do
    it 'returns true if all elements matches the condition in the original array' do
      expect(integer_arr.my_all?).to eql(true)
    end
    it 'returns true if all element matches the condition in the original string array' do
      expect(string_arr.my_all?('mango')).to eql(false)
    end
    it 'returns true if all elements matches the condition in the original array' do
      expect(integer_arr.my_all?).to eql(true)
    end
    it 'returns true if array is empty' do
      expect(empty_arr.my_all?).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'returns true if no element matches the condition' do
      expect(integer_arr.my_none?(20)).to eql(true)
    end
    it 'returns false if one element matches the requirement in string array' do
      expect(string_arr.my_none?('peach')).to eql(false)
    end
    it 'returns true  array is empty' do
      expect(empty_arr.my_none?).to eql(true)
    end
  end
  describe '#my_count' do
    it 'returns the number of elements in an array' do
      expect(integer_arr.my_count).to eql(5)
    end
  end
  describe '#my_map' do
    it 'returns new array after calling the block given' do
      expect(integer_arr.my_map { |item| item**2 }).to eql([1, 4, 9, 16, 25])
    end
    it 'returns an enumerator if no block is given' do
      expect(integer_arr.my_map).to be_a(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'returns result of using symbol when no block is given' do
      expect(integer_arr.my_inject(:+)).to eql(15)
    end
    it ' returns result when there is an argument and a block given' do
      expect(integer_arr.my_inject(5) { |a, b| a + b }).to eql(20)
    end
    it 'raise an error when string used for a mathematical operation ' do
      expect { integer_arr.my_inject('goat') }.to raise_error(StandardError)
    end
  end

  describe '#multiply_els' do
    it 'returns a value as result of the multiplication inside the block when is passed as an argument' do
      expect(multiply_els([2, 3, 4, 5])).to eql(120)
    end
  end

  it 'Raise an error' do
    expect { multiply_els }.to raise_error(StandardError)
  end
end
