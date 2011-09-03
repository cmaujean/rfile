require 'minitest/spec'
require 'minitest/autorun'
require '../lib/rfile.rb'

describe RFile do
  before(:all) do
    @f = RFile.new("rfile/test/data/testfile")
  end

  def test_rfile
    assert(@f.randomline.is_a?(String), "line is a string")
    testline = @f.randomline
    assert(valid_line(testline), "Line is valid: #{testline}")
    assert(@f.randomline) 
    assert(@f.line(1) == "Line 1", "line(1) returns Line 1: #{@f.line(1)}")
  end

  def test_enum_mixin
    g = RFile.new("rfile/test/data/testenummixin")
    count = 0
    g.each_with_index do |l,i|
      case (i+1)
      when 1
        assert_equal "Line 1", l
      when 2
        assert_equal "Line 2", l
      when 3
        assert_equal "Line 3", l
      else
        flunk "bad index: #{i}"
      end
      
      count+=1
    end
    assert count == 3, "EACH TEST: count should be 3 count is #{count}"

    assert( "Line 3" == @f.detect {|t| t.split(" ")[1].to_i == 3}, "Enum: testing detect { } " )
    assert( @f.reject {|t| t == "Line 3"} == ["Line 1", "Line 2"], "Enum: testing reject { }" )
    assert( @f.collect {|t| "This is " + t } == ["This is Line 1", "This is Line 2", "This is Line 3"], "Enum: testing collect")
  end

  def test_recycle
    g = RFile.new("rfile/test/data/testfile", true)
    5.downto 0 do
    	g.randomline
    end
    assert valid_line(g.randomline), "Recycle failed"
  end

  def test_length
    f = RFile.new("rfile/test/data/testfile")
    f.randomline
    assert_equal 2, f.length, "Length should be 2"
  end

  def test_r_eof
    f = RFile.new("rfile/test/data/testfile")
    3.downto 1 do
      f.randomline
    end
    assert f.r_eof?, "length is #{f.length}"
  end

  def test_randomlines
    f = RFile.new("rfile/test/data/testfile")

    # test block form
    f.randomlines(2) do |line|
      assert(valid_line(line), "Randomlines block form: #{line}")
    end

    g = RFile.new("rfile/test/data/testfile")

    # test array form
    arr = g.randomlines(2)
    arr.each do |line|
      assert(valid_line(line), "Randomlines array form: #{line}")
    end
  end

  def test_sep_string
    f = RFile.new("rfile/test/data/sep_string_test", false, "--")
    assert_equal "\nso here we see if this is line 4 or not.\n\n", f.line(4), "is: #{f.line(4)}"
  end

  def valid_line(line)
    case line
    when "Line 1"
      true
    when "Line 2"
      true
    when "Line 3"
      true
    else
      false
    end
  end
end

# vi:sw=2 ts=2
