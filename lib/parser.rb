require 'json'

class Parser
  PATTERNS = [
    {
        word: "killed",
        init: "killed ",
        end: " by"
    },
    {
        word: "ClientUserinfoChanged: ",
        init: " n\\",
        end: "\\t"
    }
]

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
    :lines => count_lines(),
    :players => count_players()
    }}

  JSON.pretty_generate(obj)
  end

  private

  def count_lines
    data = File.readlines(@path).count
  end

  def count_players
    players = []
    File.readlines(@path).each do |line|
      PATTERNS.each do |pattern|
        temp = line_scanner(line, pattern[:word], pattern[:init], pattern[:end])

        player_include(temp, players)
      end
    end

    players
  end

  def line_scanner(line, word, search_init, search_end)
    if line.include?(word)
      line.split(search_init).last.split(search_end).first
    end
  end

  def player_include(temp, players)
    unless temp.nil?
      unless players.include?(temp)
        players << temp
      end
    end
  end
end
