require 'test/unit'
require 'rfile/indexelement'

class TestIndexElement < Test::Unit::TestCase
  def setup
    @ie = IndexElement.new([1,2,3])
  end
  
  def test_new
    assert(@ie.kind_of?(IndexElement), "kind_of?")
    assert_raise(RuntimeError) {
     foo = IndexElement.new(["foo", "bar"])
    }
    assert_nothing_raised {
     foo = IndexElement.new([0,0,0])
    }
    
    bie = IndexElement.new {|e|
      e.length = 1
      e.offset = 2
      e.linum  = 3
    }
    assert_equal 1, bie.length, "block creation"
    assert_equal 2, bie.offset, "block creation"
    assert_equal 3, bie.linum, "block creation"
  end

  def test_accessors
    assert_equal 1, @ie.length, "length accessor"
    assert_equal 2, @ie.offset, "offset accessor"
    assert_equal 3, @ie.linum,  "linum accessor"
  end

  def test_as_h
    h = @ie.as_h
    assert_equal 1, h[:length], "hash test :length"
    assert_equal 2, h[:offset], "hash test :offset"
    assert_equal 3, h[:linum],  "hash test :linum"
  end

  def test_as_a
    a = @ie.as_a
    assert_equal 1, a[0], "array test 0"
    assert_equal 2, a[1], "array test 1"
    assert_equal 3, a[2], "array test 2"
  end
end
# vi:sw=2 ts=2
