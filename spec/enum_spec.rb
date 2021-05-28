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
    it 'returns new array that pass requirements' do
      expect(integer_arr.my_select(&:even?)).to eql([2, 4])
    end
    it 'returns new array that pass requirements' do
      expect(string_arr.my_select { |item| item.length > 1 }).to eql(%w[apple peach mango])
    end
    it 'returns an enumerator if no block is given' do
      expect(integer_arr.my_select).to be_a(Enumerator)
    end
  end
end
