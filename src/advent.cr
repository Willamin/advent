require "http/client"
require "xml"

module Advent
  VERSION = "1.0.0"
end

CACHE = ENV["ADVENT_OF_CODE_CACHE"]?.try { |path| Path[path] }

def part1_path(year, day) : Path?
  CACHE.try(&.join(year, day, "part1.html"))
end

def precheck(year, day) : String?
  return nil unless part1 = part1_path(year, day)

  return nil unless File.exists?(part1)
  return nil unless File.file?(part1)
  return nil unless File.readable?(part1)

  content = File.read(part1)
  return nil if content.blank?
  return content
end

def fetch(year, day) : String?
  if CACHE
    puts("The puzzle for #{year}/#{day} isn't in the cache. Fetching it and storing it now.")
  end

  HTTP::Client.new("adventofcode.com", tls: true)
    .get("/#{year}/day/#{day}")
    .try { |r| XML.parse_html(r.body) }
    .xpath_node(%{//article[@class="day-desc"]})
    .try(&.to_xml)
    .tap do |body|
      part1_path(year, day).try { |path| Dir.mkdir_p(path.parent); File.write(path, body) }
    end
end

def puzzle(year, day) : String?
  precheck(year, day) || fetch(year, day)
end

if ARGV[0]? == "help"
  STDOUT.puts <<-HELP
  Usage: 
      $ advent YEAR DAY     Fetches the puzzle for YEAR and DAY and prints it
      $ advent fetchall     Fetches all puzzles without printing them
      $ advent help         Displays this help

    The environment variable ADVENT_OF_CODE_CACHE can be set to indicate
      that an offline cache should be checked before fetching the puzzle from
      the Advent of Code website. Additionally, setting this variable will
      cause puzzles that are fetched from the website to be saved to the 
      directory indicated in the variable.
  HELP
  exit(0)
end

if ARGV[0]? == "fetchall"
  puzzles = 0
  (2015..Time.local.year).each do |year|
    (1..25).each do |day|
      if puzzle(year, day)
        puzzles += 1
      end
    end
  end

  STDOUT.puts("Fetched #{puzzles} puzzles. No other output is expected.")
  exit(0)
end

if year = ARGV[0]?
  if day = ARGV[1]?
    if body = puzzle(year, day)
      STDOUT.puts(body)
    else
      STDERR.puts("Fetching https://adventofcode.com/#{year}/day/#{day} failed for some reason.")
    end
  else
    STDERR.puts("Expected an advent calendar day (1 to 25) as the second argument.")
  end
else
  STDERR.puts("Expected a supported year as the first argument. Advent of Code started in 2015 and at the time of writing this, has had an event every year through 2019 with no expectation for an end.")
end
