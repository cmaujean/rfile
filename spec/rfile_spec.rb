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

  describe "enumeration mixin" do
    before do
      @f = RFile.new("#{TESTDATA}/testenummixin")
    end
    describe "each" do
      it "returns the lines in the file, in order" do
        count = 0
        @f.each_with_index do |l,i|
          l.should == "Line #{i+1}"
        end
      end
    end
    
    describe "detect" do
      it "returns the detected line" do
        @f.detect {|t| t.split(" ")[1].to_i == 3}.should == "Line 3"
      end
    end
    describe "reject" do
      it "returns the unrejected lines" do
        @f.reject {|t| t == "Line 3"}.should == ["Line 1", "Line 2"]
      end
    end
    describe "collect" do
      it "returns the collected lines" do
        @f.collect {|t| "This is " + t }.should == ["This is Line 1", "This is Line 2", "This is Line 3"]
      end
    end
  end
  describe "recycle == true" do
    it "recycles the file when the data is 'used up'" do
      g = RFile.new("#{TESTDATA}/testfile", true)
      5.downto 0 do
        g.randomline
      end
      valid_line(g.randomline).should be_true
    end
  end
  
  describe "#length" do
    it "returns the remaining number of lines in the file" do
      f = RFile.new("#{TESTDATA}/testfile")
      f.length.should == 3
      lambda {
        f.randomline
      }.should change(f, :length).by(-1)
    end
  end
  
  describe "r_eof?" do
    it "should return true when the file is at eof" do
      f = RFile.new("#{TESTDATA}/testfile")
      3.downto 1 do
        f.randomline
      end
      f.r_eof?.should be_true
    end
    it "should return false when the file has remaining lines" do
      f = RFile.new("#{TESTDATA}/testfile")
      3.downto 2 do
        f.randomline
      end
      f.r_eof?.should be_false
    end
  end

  describe "randomlines" do
    before :each do
      @f = RFile.new("#{TESTDATA}/testfile")
    end
    
    it "handles block form and processes the number of lines requested" do
      @f.randomlines(2) do |line|
        valid_line(line).should be_true
      end
    end
    
    it "handles array form and returns the number of lines requested" do
      arr = @f.randomlines(2)
      arr.each do |line|
        valid_line(line).should be_true
      end
    end
  end
  
  describe "separator string works" do
    it "properly handles alternate separator strings" do
      f = RFile.new("#{TESTDATA}/sep_string_test", false, "--")
      f.line(4).should == "\nso here we see if this is line 4 or not.\n\n"
    end
  end
end
# vi:sw=2 ts=2
