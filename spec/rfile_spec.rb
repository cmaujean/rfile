require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + "/../lib/rfile.rb")

TESTDATA = File.expand_path(File.dirname(__FILE__) + "/data" )
describe RFile do
  describe "#randomline" do
    before do
      @f = RFile.new("#{TESTDATA}/testfile")
    end
    
    it "returns a string" do
      @f.randomline.should be_kind_of(String)
    end
    
    it "returns a line from the file it loaded" do
      valid_line(@f.randomline).should == true
    end
    
  end
  describe "#line do" do
    before do
      @f = RFile.new("#{TESTDATA}/testfile")
    end
    it "returns the requested line" do
      @f.line(1).should == "Line 1"
    end
  end
end

  # 
  # 
  # describe "enumeration mixin" do
  #   it "returns all of the lines in the file, in order"
  #   g = RFile.new("rfile/test/data/testenummixin")
  #   count = 0
  #   g.each_with_index do |l,i|
  #       assert_equal "Line 1", l
  #       assert_equal "Line 2", l
  #       assert_equal "Line 3", l
  #   end
  #   assert count == 3, "EACH TEST: count should be 3 count is #{count}"
  # 
  #   assert( "Line 3" == @f.detect {|t| t.split(" ")[1].to_i == 3}, "Enum: testing detect { } " )
  #   assert( @f.reject {|t| t == "Line 3"} == ["Line 1", "Line 2"], "Enum: testing reject { }" )
  #   assert( @f.collect {|t| "This is " + t } == ["This is Line 1", "This is Line 2", "This is Line 3"], "Enum: testing collect")
  # end
  # 
  # def test_recycle
  #   g = RFile.new("rfile/test/data/testfile", true)
  #   5.downto 0 do
  #     g.randomline
  #   end
  #   assert valid_line(g.randomline), "Recycle failed"
  # end
  # 
  # def test_length
  #   f = RFile.new("rfile/test/data/testfile")
  #   f.randomline
  #   assert_equal 2, f.length, "Length should be 2"
  # end
  # 
  # def test_r_eof
  #   f = RFile.new("rfile/test/data/testfile")
  #   3.downto 1 do
  #     f.randomline
  #   end
  #   assert f.r_eof?, "length is #{f.length}"
  # end
  # 
  # def test_randomlines
  #   f = RFile.new("rfile/test/data/testfile")
  # 
  #   # test block form
  #   f.randomlines(2) do |line|
  #     assert(valid_line(line), "Randomlines block form: #{line}")
  #   end
  # 
  #   g = RFile.new("rfile/test/data/testfile")
  # 
  #   # test array form
  #   arr = g.randomlines(2)
  #   arr.each do |line|
  #     assert(valid_line(line), "Randomlines array form: #{line}")
  #   end
  # end
  # 
  # def test_sep_string
  #   f = RFile.new("rfile/test/data/sep_string_test", false, "--")
  #   assert_equal "\nso here we see if this is line 4 or not.\n\n", f.line(4), "is: #{f.line(4)}"
  # end

def valid_line(line)
  ["Line 1", "Line 2", "Line 3"].include? line
end

# vi:sw=2 ts=2
