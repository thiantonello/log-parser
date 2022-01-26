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
    raise 'File not found' unless File.exist?(path)

    @players = []
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
    list_players

    obj = {
      file => {
        lines: count_lines,
        players: @players
      }
    }

    JSON.pretty_generate(obj)
  end

  private

  def count_lines
    File.readlines(@path).count
  end

  def list_players
    File.readlines(@path).each do |line|
      PATTERNS.each do |pattern|
        include_player(find_player(line, pattern))
      end
    end
  end

  def find_player(line, pattern)
    return unless line.include?(pattern[:word])

    line.split(pattern[:init]).last.split(pattern[:end]).first
  end

  def include_player(player_name)
    return unless player_name

    @players << player_name unless @players.include?(player_name)
  end
end
