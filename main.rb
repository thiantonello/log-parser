require "./lib/parser"
require "json"

parser = Parser.new("./fixtures/games.log")

puts parser.generate_json
