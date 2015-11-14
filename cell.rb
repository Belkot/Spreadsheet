module Cell

  require "./cell/base.rb"
  require "./cell/error.rb"
  require "./cell/nothing.rb"
  require "./cell/text.rb"
  require "./cell/number.rb"
  require "./cell/reference.rb"
  require "./cell/expression.rb"

  def self.build(str=nil)
    if str == ''
      Nothing.new
    elsif str[/\-?\d+\.?\d*/] == str
      Number.new str
    elsif str[0] == '\''
      Text.new str[1..-1]
    elsif str[/\=[A-Z]+\d+/] == str
      Reference.new str[1..-1]
    elsif str[0] == '='
      Expression.new str[1..-1]
    else
      Error.new str
    end
  end

end
