require "./lib/parser"
require "json"

parser = Parser.new("./fixtures/games.log")

print parser.first_line

puts

puts parser.count_lines_json
