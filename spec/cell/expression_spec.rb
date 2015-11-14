require "./cell/base.rb"
require "./cell/expression.rb"
require "./cell/reference.rb"
require "./cell/number.rb"
require "./cell/error.rb"

describe 'Expression' do

  it 'set value' do
    cell = Cell::Expression.new 'A1+B2-8'
    cell.value = '2+2*3'
    expect(cell.to_s).to eq '2+2*3'
    expect(cell.value).to include(:+, :*)
  end

  it 'invalid set value' do
    cell = Cell::Expression.new 'A1+8'
    cell.value = 'A1+2d+8'
    expect(cell.value.first).to be_a Cell::Error
    expect(cell.to_s).to eq '# error parse expression: A1+2d+8'
  end

  it 'calculate value' do
    cell = Cell::Expression.new '5+3-7'
    cell.calculate!
    expect(cell.value.first.value).to eq 1
  end

end
