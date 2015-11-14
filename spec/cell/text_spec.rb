require "./cell/base.rb"
require "./cell/text.rb"

describe 'Text' do

  it 'set value' do
    cell = Cell::Text.new 'text'
    cell.value = 'text2'
    expect(cell.to_s).to eq 'text2'
  end

  it 'set integer value' do
    cell = Cell::Text.new 4
    cell.value = 5
    expect(cell.to_s).to eq '5'
  end

  it 'set float value' do
    cell = Cell::Text.new 4
    cell.value = 5.03
    expect(cell.to_s).to eq '5.03'
  end

end
