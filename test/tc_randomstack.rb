require 'test/unit'
require 'rfile/randomstack'

class TestRandomStack < Test::Unit::TestCase
  def setup
    @rstack = RandomStack.new([ "foo", "bar", "baz" ])
  end
  
  def test_length_and_pop
    popval = []

    3.downto(1) do |i|
      assert_equal i, @rstack.length, "length and pop, length test: i = #{i} and length = #{@rstack.length}"
      val = @rstack.pop 
      assert(!popval.include?(val))
      popval.push val
      assert(%W(foo bar baz).include? val)
    end

    assert_equal 0, @rstack.length
    assert_nil @rstack.pop
  end

  def test_add_item
    @rstack.add_item ["foo1", "bar1", "baz1"]
    @rstack.each { |item|
      if (item[0] == "foo1") 
        assert true, "item was inserted"
        return
      end
    }
    flunk "never found inserted item"
  end
end

# vi:sw=2 ts=2
