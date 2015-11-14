require "./cell/base.rb"
require "./cell/reference.rb"

describe 'Reference' do

  it 'set value' do
    cell = Cell::Reference.new 'text'
    cell.value = 'text2'
    expect(cell.to_s).to eq 'text2'
  end

end
