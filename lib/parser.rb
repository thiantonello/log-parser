require 'json'

class Parser
  def initialize(path)
    @path = path
  end

  def first_line
    data = File.open(@path)
    content = data.readline
    data.close
    content
  end
  
  def generate_json
    file = @path.split("/").last
    
    obj = { file => {
      :lines => count_lines()
      } }
      
    JSON.pretty_generate(obj)
    end

    private

    def count_lines
      data = File.readlines(@path).count
    end
end
