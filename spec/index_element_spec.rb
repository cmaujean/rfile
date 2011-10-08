require 'spec_helper'
require 'rfile/indexelement'

describe "IndexElement" do
  before :each do
    @ie = IndexElement.new([1,2,3])
  end
  
  describe "new" do
    it "returns a new IndexElement" do
      @ie.should be_kind_of(IndexElement)
    end
    
    it "raises an error when passed an array of strings" do
      lambda {
        foo = IndexElement.new(["foo", "bar"])
      }.should raise_error(RuntimeError)
    end
    
    it "does not raise an error when passed an array of integers" do
      lambda {
        foo = IndexElement.new([0,0,0])
      }.should_not raise_error
    end 
    
    it "accepts a block" do
      bie = IndexElement.new {|e|
        e.length = 1
        e.offset = 2
        e.linum  = 3
      }
      bie.length.should == 1
      bie.offset.should == 2
      bie.linum.should == 3
    end

  end
  
  describe "accessors" do
    it "has an accessor for length" do
      @ie.length.should == 1
    end
    it "has an accessor for offset" do
      @ie.offset.should == 2
    end
    it "has an accessor for linum" do
      @ie.linum.should == 3
    end
  end
  
  describe "as_h" do
    it "returns a hash with keys length, offset and linum" do
      h = @ie.as_h
      h.should == {:length => 1, :offset => 2, :linum => 3}
    end
  end
  
  describe "as_a" do
    it "returns an array like [length, offset, linum]" do
      a = @ie.as_a
      a.should == [1,2,3]
    end
  end
end

