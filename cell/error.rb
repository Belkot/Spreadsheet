module Cell

  class Error < Base

    def initialize(arg)
      arg = '# error ' << arg
      super arg
    end

  end

end
