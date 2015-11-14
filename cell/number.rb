module Cell

  class Number < Base

    def value=(arg)
      if arg.to_f == arg.to_i
        @value = arg.to_i
      else
        @value = arg.to_f
      end
    end

    def +(other)
        Number.new(@value + other.value)
      rescue
        Error.new('summation')
    end

    def -(other)
        Number.new(@value - other.value)
      rescue
        Error.new('subtraction')
    end

    def *(other)
        Number.new(@value * other.value)
      rescue
        Error.new('multiplication')
    end

    def /(other)
        if other.value.zero?
          Error.new('division to 0')
        else
          Number.new(@value.to_f / other.value)
        end
      rescue
        Error.new('division')
    end

  end

end
