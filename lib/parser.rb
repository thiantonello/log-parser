# frozen_string_literal: true

require 'json'

# Parse the code, extract information and generate JSON
class Parser
  PATTERNS = [
    {
      word: 'killed',
      init: 'killed ',
      end: ' by'
    },
    {
      word: 'ClientUserinfoChanged: ',
      init: ' n\\',
      end: '\\t'
    }
  ].freeze

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
    file = @path.split('/').last

    obj = {
      file => {
        lines: count_lines,
        players: count_players
      }
    }

    JSON.pretty_generate(obj)
  end

  private

  def count_lines
    File.readlines(@path).count
  end

  def count_players
    players = []

    File.readlines(@path).each do |line|
      PATTERNS.each do |pattern|
        player_name = line_scanner(line, pattern)

        player_include(player_name, players)
      end
    end

    players
  end

  def line_scanner(line, pattern)
    return unless line.include?(pattern[:word])

    line.split(pattern[:init]).last.split(pattern[:end]).first
  end

  def player_include(player_name, players)
    return unless player_name
    return players << player_name unless players.include?(player_name)
  end
end
