# Log Parser

## Project Description

- The objective of this project is to parse a log file and extract useful information from it.

## Technologies Used

- Ruby ~> 3.1.0

- Ruby Gems:
  -- Bundler ~> 2.3.5
  -- RSpec ~> 3.10

- asdf (single CLI version manager for multiple languages)

## Project Setup

- install asdf
  https://github.com/asdf-vm/asdf
  http://asdf-vm.com/guide/getting-started.html#_1-install-dependencies

- install Ruby v.3.1.0 via asdf

        $ asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

        $ asdf install ruby 3.1.0

        $ asdf global ruby 3.1.0

- clone this repository
  e.g. via ssh:

        $ git clone git@github.com:thiantonello/log-parser.git

- inside your project folder
  install Bundler:

        $ gem install bundler

  install gems:

        $ bundle install

## How to Use the Project

- run the program

        $ ruby main.rb

- you may use irb (interaction e.g. below)

        $ irb

        $ require "./lib/parser"

        $ parser = Parser.new("./fixtures/games.log")

        $ parser.first_line

- run all tests

        $ bundle exec rspec

- run an specific test:

        $ rspec <test_path>

#### Made by

<a href="https://github.com/thiantonello" target="_blank" rel="noreferrer">@thiantonello</a>
