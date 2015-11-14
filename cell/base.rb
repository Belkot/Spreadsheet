module Cell

  class Base

    attr_reader :value

    def initialize(arg)
      self.value = arg
    end

    def value=(arg)
      @value = arg
    end

    def to_s()
      @value.to_s
    end

  end

end
