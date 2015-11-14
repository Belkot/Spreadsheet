require "./cell/base.rb"

describe 'Base' do

  it 'init' do
    cell = Cell::Base.new 'c1'
    expect(cell.to_s).to eq 'c1'
  end

  it 'set value string' do
    cell = Cell::Base.new 'a1'
    cell.value = 'c1'
    expect(cell.to_s).to eq 'c1'
  end

  it 'set value float' do
    cell = Cell::Base.new 5.2
    cell.value = 7.8
    expect(cell.to_s).to eq '7.8'
  end

  it 'set value nil' do
    cell = Cell::Base.new 5.2
    cell.value = nil
    expect(cell.to_s).to eq ''
  end

end
