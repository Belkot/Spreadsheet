require "./cell/base.rb"
require "./cell/nothing.rb"

describe 'Nothing' do

  it 'init with nil' do
    cell = Cell::Nothing.new
    expect(cell.to_s).to eq ''
  end

  it 'init with some obj' do
    cell = Cell::Nothing.new 'fd'
    expect(cell.to_s).to eq ''
  end

end
