require "./cell/base.rb"
require "./cell/error.rb"
require 'spec_helper.rb'

describe 'Error' do

  it 'init' do
    cell = Cell::Error.new 'text'
    expect(cell.to_s).to eq '# error text'
    expect(cell.value).to eq '# error text'
  end

end
