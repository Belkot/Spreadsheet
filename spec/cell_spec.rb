require "./cell.rb"

describe 'Cell' do

  it 'build nothing' do
    cell = Cell.build ''
    expect(cell).to be_a Cell::Nothing
    expect(cell.value).to be_nil
  end

  it 'build number' do
    cell = Cell.build '3.6'
    expect(cell).to be_a Cell::Number
    expect(cell.value).to eq 3.6
  end

  it 'build text' do
    cell = Cell.build "'text"
    expect(cell).to be_a Cell::Text
    expect(cell.value).to eq 'text'
  end

  it 'build references' do
    cell = Cell.build '=AAZ88'
    expect(cell).to be_a Cell::Reference
    expect(cell.value).to eq 'AAZ88'
  end

  it 'build expression' do
    cell = Cell.build '=AAZ88+2/B1'
    expect(cell).to be_a Cell::Expression
    expect(cell.value).to include( Cell::Reference, :+, :/ )
  end

  it 'build error' do
    cell = Cell.build 'ds'
    expect(cell).to be_a Cell::Error
    expect(cell.value).to eq '# error ds'
  end

end
