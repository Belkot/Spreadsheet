require "./sheet.rb"

describe 'Sheet' do

  context 'valid output' do

    it 'when no input' do
      input = ''
      sheet = Sheet.new input
      sheet.evaluate!
      expect(sheet.to_s).to eq ""
    end

    it 'with nothing in A1' do
      input = "\t5"
      sheet = Sheet.new input
      sheet.evaluate!
      expect(sheet.to_s).to eq input
    end

    it 'with integer' do
      input = "1\t5"
      sheet = Sheet.new input
      sheet.evaluate!
      expect(sheet.to_s).to eq input
    end

    it 'with float' do
      input = "1.0001\t5.3"
      sheet = Sheet.new input
      sheet.evaluate!
      expect(sheet.to_s).to eq input
    end

    it 'with text' do
      input = "'text1\t'text2"
      sheet = Sheet.new input
      sheet.evaluate!
      expect(sheet.to_s).to eq "text1\ttext2"
    end

    it 'with simple expression' do
      input = "=5\t=2"
      sheet = Sheet.new input
      sheet.evaluate!
      expect(sheet.to_s).to eq "5\t2"
    end

    it 'with operations in expression' do
      input = "=5+1\t=2-1\t=3*2\t=10/2"
      sheet = Sheet.new input
      sheet.evaluate!
      expect(sheet.to_s).to eq "6\t1\t6\t5"
    end

    it 'with references and operations in expression' do
      input = "12\t=C2\t3\t'Sample\n=A1+B1*C1/5\t=A2*B1\t=B3-C3\t'Spread\n'Test\t=4-3\t5\t'Sheet"
      sheet = Sheet.new input
      sheet.evaluate!
      expect(sheet.to_s).to eq "12\t-4\t3\tSample\n9.6\t-38.4\t-4\tSpread\nTest\t1\t5\tSheet"
    end

  end

  context 'valid cell by name' do

    it 'with references and operations in expression' do
      input = "12\t=C2\t3\t'Sample\n=A1+B1*C1/5\t=A2*B1\t=B3-C3\t'Spread\n'Test\t=4-3\t5\t'Sheet"
      sheet = Sheet.new input
      sheet.evaluate!
      expect(sheet['A2'].value).to eq 9.6
    end

    it 'with nothing in A1' do
      input = "\t5"
      sheet = Sheet.new input
      sheet.evaluate!
      expect(sheet['B1'].value).to eq 5
    end

  end

  context 'get and set cell' do

    it 'copy cell' do
      input = "\t5"
      sheet = Sheet.new input
      sheet['A1'] = sheet['B1']
      sheet.evaluate!
      expect(sheet.to_s).to eq "5\t5"
    end

  end

end