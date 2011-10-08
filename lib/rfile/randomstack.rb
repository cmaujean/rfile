# A randomizing stack
# <i>note: there is no way to set or predict the order of items
#          stored or returned.</i>
class RandomStack
  include Enumerable

  # incoming is an array that becomes the stack data
  def initialize(incoming)
    incoming.compact
    @stack = incoming.clone
    self.shuffle
  end

  # reshuffles the stack.
  def shuffle
    @stack = @stack.sort_by { rand }.clone
  end

  # removes the top entry from the stack and returns it.
  def pop
    @stack.pop
  end
  
  # returns the number of items left in the stack
  def length
    @stack.length
  end

  # yields each item in turn
  def each #yields:nextitem
    @stack.each {|s| yield s}
  end

  # add the provided item to the stack at a random point
  # note: this changes the order internally
  def add_item(new_item)
    rndspot = rand(@stack.length)
    save = @stack[rndspot]
    @stack[rndspot] = new_item
    @stack.push save
  end 
end
