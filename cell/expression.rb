module Cell

  class Expression < Base

    def value=(arg)
      error = nil
      val = arg.split(/(?<=[\+\-\*\/])|(?=[\+\-\*\/])/)
      @value = val.map do |e|
        if e =~ /[\+\-\*\/]/
          e.to_sym
        else
          if e[/[A-Z]+\d+/] == e
            Reference.new e
          elsif e[/\-?\d+\.?\d*/] == e
            Number.new e
          else
            error = true
            Text.new e
          end
        end
      end
      @value = @value.unshift(Error.new 'parse expression: ') if error
    end

    def to_s()
      @value.map { |e| e.to_s }.join
    end

    # # Calculate from first to end of array (#BUG In sample cell A2 = 9.6, but we have 4.8)
    # def calculate!(start_index= 0)
    #   if @value[start_index].instance_of?(Number) &&  @value[start_index + 1].instance_of?(Symbol) && @value[start_index + 2].instance_of?(Number)
    #     @value[start_index] = @value[start_index].send( @value[start_index + 1], @value[start_index + 2] )
    #     @value[start_index + 1] = nil
    #     @value[start_index + 2] = nil
    #     @value = @value.compact
    #     calculate! start_index
    #   else
    #     start_index += 1
    #     calculate! start_index if start_index < @value.size - 2
    #   end
    # end
    #
    # # Calculate from end to first element of array (In sample cell A2 = 9.6)
    def calculate!(start_index= -1)
      if @value[start_index].instance_of?(Number) &&
         @value[start_index - 1].instance_of?(Symbol) &&
         @value[start_index - 2].instance_of?(Number)

        @value[start_index-2] = @value[start_index-2].send( @value[start_index - 1], @value[start_index] )
        @value[start_index] = nil
        @value[start_index - 1] = nil
        @value = @value.compact
        calculate! start_index
      else
        start_index -= 1
        calculate! start_index if start_index < -@value.size - 2
      end
    end

  end

end
