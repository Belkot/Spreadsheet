require "./sheet.rb"

sheet = Sheet.new $stdin.read
sheet.evaluate!
puts sheet
