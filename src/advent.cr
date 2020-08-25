require "http/client"
require "json"
require "option_parser"

require "stdimp/string/puts"
require "stdimp/string/prepend"
require "stdimp/string/append"

require "./advent/*"

module Advent
  VERSION = "0.0.0"
end

module Enumerable
  def conjunctify(conjunction = "and", two_separator = " ", three_separator = ", ") : String
    e = self.map(&.to_s)
    case e.size
    when 0 then ""
    when 1 then e[0]
    when 2 then e.join(two_separator)
    else
      String.build do |s|
        e.each_with_index do |v, i|
          s << v
          if i != e.size - 1
            s << three_separator
          end
          if i == e.size - 2
            s << conjunction
            s << two_separator
          end
        end
      end
    end
  end
end

class Object
  def pipe_if(condition : Bool)
    if condition
      yield self
    else
      self
    end
  end

  def pipe_unless(condition : Bool)
    unless condition
      yield self
    else
      self
    end
  end
end
