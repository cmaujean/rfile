require 'rfile/randomstack'
require 'rfile/indexelement'

# This class is a line oriented file object that operates
# without keeping the file in memory.
# 
# Enumerable is mixed in, see Enumerable for more
# information.
# 
class RFile
  include Enumerable
  attr_accessor :recycle, :filename

  # parses and indexes <i>filename</i>.
  #
  # if recycle == true, the randomline 
  # method will reload the index (fast)
  # when it runs out of unique lines to produce
  #
  # if sep_string is passed, "lines" will be determined
  # by sep_string instead of $/
  #--
  # storing line information (length, offset, )
  #++
  def initialize(filename, recycle=false, sep_string=$/)
    @filename  = filename
    @recycle = recycle
    @sep_string = sep_string
    @index     = Array.new
    @rndindex  = []
    count      = 0
    offset     = 1

    File.open(@filename).each_line(@sep_string) do |line|
      @index[count] = IndexElement.new([line.length, offset-1, count+1])     
      offset += line.length
      count+=1
    end
    @rndindex = RandomStack.new(@index.clone)
  end

  # returns a random line from the file. will not repeat lines. 
  # returns nil when the file is exausted. note: does not modify file. 
  def randomline
    entry = nil
    if @recycle and @rndindex.length == 0 
      @rndindex = RandomStack.new(@index)
    end
    while(entry.nil? and @rndindex.length > 0)
      entry = @rndindex.pop
    end
    entry.nil? and return nil
    return line(entry.linum) 
  end

  # return true if there are no lines left for randomline(s) ( only useful if
  # recycle=true )
  def r_eof?
    return true if @rndindex.length == 0
    false
  end

  # yields num random lines or returns them as an array. see randomline for details
  def randomlines(num) #:yields:line
    arr = Array.new
    doyield = block_given?
    num.times do |i|
      rline = randomline()
        yield rline if doyield
        arr.push rline
    end
    arr if not doyield
  end

  # returns the number of lines available to randomline based methods
  # in the current cycle. useful if you want to know how close you
  # are to recycling the file, or how close to r_eof? == true
  def length
    @rndindex.length
  end

  # returns the line at num (provided num is greater than or equal to 1)
  # returns nil if num is larger than the lines available
  def line(num)
    if (num < 1) or (num > @index.length)
      raise "line number: #{num} is out of bounds"
    end
    entry = @index[num-1]
    IO.read(@filename, entry.length, entry.offset).chomp(@sep_string)
  end
  
  # yields each line in the file, in turn.
  # 
  # <i>note: currently IO intensive as it will open and close the file
  # for each line.</i>
  #  
  def each # :yields:line
    @index.each do |entry|
      yield line(entry.linum) unless entry.nil?
    end
  end
end

require 'rfile/version'

# vi:sw=2 ts=2
