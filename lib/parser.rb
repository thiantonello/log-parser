require 'json'

class Parser
  def initialize(file)
    @file = file
  end

  def first_line
    data = File.open(@file)
    content = data.readline
    data.close
    content
  end

  def count_lines
    data = File.readlines(@file).count
  end

  def count_lines_json
    file = @file.split("/").last
    lines = count_lines()

    obj = { file => {
      :lines => lines
    } }

    JSON.pretty_generate(obj)
  end
end
