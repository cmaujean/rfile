require 'spec_helper'
require 'rfile/randomstack'

describe "RandomStack" do
  before :each do
    @rstack = RandomStack.new([ "foo", "bar", "baz" ])
  end
  
  describe "length" do
    it "should report the length of the stack" do
      3.downto(1) do |i|
        @rstack.length.should == i
        val = @rstack.pop 
      end

      @rstack.length.should == 0
    end
  end

  describe "pop" do
    it "should return an element" do
      @rstack.pop.should_not be_nil
    end
    it "should return nil when there are no elements left" do
      3.downto(1) do
        @rstack.pop
      end
      @rstack.pop.should be_nil
    end
  end

  describe "add_item" do
    it "should add items to the stack" do
      @rstack.add_item ["foo1", "bar1", "baz1"]
      found = false
      @rstack.each { |item|
        if (item[0] == "foo1") 
          found = true
        end
      }
      found.should be_true
    end
  end
end
