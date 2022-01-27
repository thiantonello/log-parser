# frozen_string_literal: true

require 'json'

# Parse the code, extract information and generate JSON
class Parser
  PARSE_PATTERNS = {
    user_info_changed:
      {
        word: 'ClientUserinfoChanged: ',
        init: ' n\\',
        end: '\\t'
      },
    kill:
      {
        word: 'killed',
        init: ': ',
        end: ' killed '
      },
    world:
      {
        word: '<world>',
        init: ' killed ',
        end: ' by '
      }
  }.freeze

  def initialize(path)
    raise 'File not found' unless File.exist?(path)

    @path = path
    @players = []
    @total_kills = 0
    @kill_score = {}
  end

  def first_line
    data = File.open(@path)
    content = data.readline
    data.close
    content
  end

  def output_json
    JSON.pretty_generate(generate_json)
  end

  private

  def generate_json
    file_name = @path.split('/').last
    process_games_info

    {
      file_name => {
        lines: count_file_lines,
        players: @players,
        kills: @kill_score,
        total_kills: @total_kills
      }
    }
  end

  def count_file_lines
    File.readlines(@path).count
  end

  def process_games_info
    File.readlines(@path).each do |line|
      @total_kills += 1 if line.include?('killed')

      register_players(
        find_player_name(line, PARSE_PATTERNS[:user_info_changed])
      )

      check_kill_records(
        find_player_name(line, PARSE_PATTERNS[:kill])
      )

      check_world_kill(
        find_player_name(line, PARSE_PATTERNS[:world])
      )
    end
  end

  def find_player_name(line, pattern)
    return unless line.include?(pattern[:word])

    line.split(pattern[:init]).last.split(pattern[:end]).first
  end

  def register_players(player_name)
    return unless player_name

    return if @players.include?(player_name)

    @players.push(player_name)
    @kill_score.store(player_name, 0)
  end

  def check_kill_records(player_name)
    return unless player_name
    return if player_name == '<world>'

    @kill_score[player_name] += 1
  end

  def check_world_kill(player_name)
    return unless player_name

    @kill_score[player_name] -= 1
  end
end
