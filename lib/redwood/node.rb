module Redwood
  class Node
    include Redwood
    
    attr_reader :name
    attr_accessor :value
    
    def initialize(name=nil, parent=nil)
      @name = name
      @parent = parent
    end
    
    # Creates a child, adds it to children, and returns the child
    def add_child(name)
      child = self.class.new(name, self)
      yield child if block_given?
      children << child
      child
    end
    
    def <<(child)
      child.instance_variable_set(:@parent, self)
      children << child
      child
    end
    
    def [](key)
      selected_child = children.select {|child| child.name == key }
      selected_child.size.eql?(1) ? selected_child.first : selected_child
    end
    
  end
end