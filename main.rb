# frozen_string_literal: true

require './lib/parser'
require 'json'

parser = Parser.new('./data/games.log')

puts parser.output_json
