require "./advent"

struct Options
  property command : Symbol = :none
  property verbose : Bool = false
  property help_for_sub : Bool = false
  property json : Bool = false
end

options = Options.new

parser = OptionParser.new do |parser|
  parser.banner = "Usage: advent [subcommand] [arguments]"
  parser.on("years", "Fetch the available years") do
    options.command = :fetch_years
    parser.on("--json", "Show results in json") { options.json = true }
  end
  parser.on("-v", "--verbose", "Enabled verbose output") { options.verbose = true }
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
end

parser.parse

case options.command
when :fetch_years
  STDERR.puts "Fetching available years" if options.verbose
  if options.json
    Advent::YearFetcher.new.main.json.puts(STDOUT)
  else
    Advent::YearFetcher.new.main.plaintext.puts(STDOUT)
  end
else
  puts parser
  exit(1)
end
