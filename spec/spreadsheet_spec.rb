describe 'Spreadsheet' do

  it "run app" do
    output = %x(ruby spreadsheet.rb < ./spec/test_input.txt)
    expect(output).to eq "12\t-4\t3\tSample\n9.6\t-38.4\t-4\tSpread\nTest\t1\t5\tSheet\n"
  end

end
