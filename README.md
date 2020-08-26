# advent

A quick tool for caching Advent of Code problems offline.

## Limitations

Currently, this tool only works unauthenticated. Because of the way Advent of Code is designed to work, this means that only Part 1 of each day's puzzles will be fetchable. I do plan to add authentication to this tool, however Part 2 of each day's puzzles will only be fetchable after Part 1 is submitted correctly (if I understand correctly). 

## Usage

  - `$ advent YEAR DAY`    Fetches the puzzle for YEAR and DAY and prints it
  - `$ advent fetchall`    Fetches all puzzles without printing them
  - `$ advent help`        Displays this help

  The environment variable `ADVENT_OF_CODE_CACHE` can be set to indicate
    that an offline cache should be checked before fetching the puzzle from
    the Advent of Code website. Additionally, setting this variable will
    cause puzzles that are fetched from the website to be saved to the 
    directory indicated in the variable.

## Contributing

1. Fork it (<https://github.com/Willamin/advent/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Will Lewis](https://github.com/Willamin) - creator and maintainer
