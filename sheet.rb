require "./cell.rb"

class Sheet

  TAB = "\t"

  def initialize(str)
    @cells = {}
    row_index = 1
    str.each_line do |row|
      col_index = 'A'
      row.split(TAB).each do |c|
        @cells[col_index + row_index.to_s] = Cell.build(c.chomp)
        col_index.next!
      end
      row_index += 1
    end
  end

  def [](key)
    @cells[key]
  end

  def []=(key, cell)
    @cells[key] = cell
  end

  def evaluate!(multithread: true)
    round = 0
    count = 1
    while count > 0
      count = 0
      calculate_expression! multithread: :multithread
      if :multithread
        t_expression = Thread.new { check_expression! }
        t_reference = Thread.new { check_reference! }
        count += t_expression.value
        count += t_reference.value
      else
        count += check_expression!
        count += check_reference!
      end
      round += 1
    end
    round
  end

  def to_s()
    result = ''
    last_row_name = 1
    @cells.each_pair do |key, cell_val|
      if last_row_name == key[/\d+/].to_i
        result << TAB
      else
        result << "\n"
        last_row_name = key[/\d+/].to_i
      end
      result << cell_val.to_s
    end
    result.partition("\t").last
  end

  private

    def expressions()
      @cells.select { |k, v| v.instance_of?(Cell::Expression) }
    end

    def calculate_expression!(multithread: true)
      if :multithread
        t_group = ThreadGroup.new
        expressions.each_value { |cell| t_group.add(Thread.new { cell.calculate! }) }
        t_group.list.each { |t| t.join }
      else
        expressions.each_value { |cell| cell.calculate! }
      end
    end

    def check_expression!()
      count = 0
      expressions.each_pair { |key, cell|
        if cell.value.size == 1 && cell.value.first.instance_of?(Cell::Number)
          @cells[key] = cell.value.first
          count += 1
        end
      }
      count
    end

    def check_reference!()
      count = 0
      @cells.each do |key, cell|
        if cell.instance_of?(Cell::Expression)
          cell.value.each_with_index { |e, i|
            if e.instance_of?(Cell::Reference) && @cells[e.value].instance_of?(Cell::Number)
              @cells[key].value[i] = @cells[e.value]
              count += 1
            end
          }
        end
        if cell.instance_of?(Cell::Reference)
          @cells[key] = @cells[cell.value] if @cells[cell.value].instance_of?(Cell::Number)
          count += 1
        end
      end
      count
    end

end
