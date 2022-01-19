require "./lib/parser"

parser = Parser.new("./fixtures/games.log")

print parser.first_line
