# length, offset and line number for an indexed chunk of file
class IndexElement
  attr_accessor :length, :offset, :linum
  @length = 0
  @offset = 0
  @linum  = 0

  # input index_data must be an array of 3 numbers
  def initialize(index_data=[0,0,0]) #yields:element
      index_data.each do |i| 
        if not i.kind_of? Fixnum and not i.kind_of? Bignum
          raise "attempt to set invalid index"
        end
      end
      if block_given?
        yield self
      else
        (@length,@offset,@linum) = index_data
      end
  end
 
  # returns hash containing  :length, :offset, :linum 
  def as_h
    {:length => @length, :offset => @offset, :linum => @linum}
  end

  # returns array containing [length, offset, linum]
  def as_a
    [@length,@offset,@linum]
  end
end

# vi:sw=2 ts=2
