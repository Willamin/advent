class Advent::YearFetcher
  @years : Array(Int32) = [] of Int32

  def main
    client = HTTP::Client.new("adventofcode.com", tls: true)

    @years = (2010..Time.local.year)
      .select do |year|
        client.get("/#{year}").status.success?
      end

    self
  end

  def plaintext
    @years
      .conjunctify
      .prepend("The available years are ")
      .append(".")
  end

  def json
    {years: @years}.to_json
  end
end
