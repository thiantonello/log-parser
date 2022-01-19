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
end
