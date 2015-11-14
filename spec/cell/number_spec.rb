require "./cell/base.rb"
require "./cell/number.rb"
require "./cell/error.rb"

describe 'Number' do

  it 'set integer value' do
    cell = Cell::Number.new 2
    cell.value = 5
    expect(cell.to_s).to eq '5'
    expect(cell.value).to eq 5
  end

  let(:arg_int1) { Cell::Number.new 4 }

  context 'valid operations' do

    let(:arg_int2) { Cell::Number.new 2 }
    let(:arg_float) { Cell::Number.new 2.5 }

    context 'summation' do

      it 'integer' do
        cell = arg_int1 + arg_int2
        expect(cell.value).to eq 6
      end

      it 'float' do
        cell = arg_int1 + arg_float
        expect(cell.value).to eq 6.5
      end

    end

    context 'summation' do

      it 'integer' do
        cell = arg_int1 - arg_int2
        expect(cell.value).to eq 2
      end

      it 'float' do
        cell = arg_int1 - arg_float
        expect(cell.value).to eq 1.5
      end

    end

    context 'multiplication' do

      it 'integer' do
        cell = arg_int1 * arg_int2
        expect(cell.value).to eq 8
      end

      it 'float' do
        cell = arg_int1 * arg_float
        expect(cell.value).to eq 10
      end
    end

    context 'division' do

      it 'integer' do
        cell = arg_int1 / arg_int2
        expect(cell.value).to eq 2
      end

      it 'float' do
        cell = arg_int1 / arg_float
        expect(cell.value).to eq 1.6
      end

    end

  end

  context 'invalid operations' do

    it 'summation' do
      cell = arg_int1 + 5
      expect(cell).to be_a Cell::Error
      expect(cell.value).to eq '# error summation'
    end

    it 'subtraction' do
      cell = arg_int1 - 5
      expect(cell).to be_a Cell::Error
      expect(cell.value).to eq '# error subtraction'
    end

    it 'multiplication' do
      cell = arg_int1 * 5
      expect(cell).to be_a Cell::Error
      expect(cell.value).to eq '# error multiplication'
    end

    it 'division' do
      cell = arg_int1 / 5
      expect(cell).to be_a Cell::Error
      expect(cell.value).to eq '# error division'
    end

    it 'division to 0' do
      cell = arg_int1 / Cell::Number.new(0)
      expect(cell).to be_a Cell::Error
      expect(cell.value).to eq '# error division to 0'
    end

  end

end
