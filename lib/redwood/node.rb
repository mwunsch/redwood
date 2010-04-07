module Redwood
  class Node
    
    attr_reader :name, :parent
    
    def initialize(name=nil, parent=nil)
      @name = name
      @parent = parent
    end
    
    def root?
      parent.nil?
    end
    
    def root
      if root?
        self
      else
        parent.root
      end
    end
    
    # Creates a child, adds it to children, and returns the child
    def add_child(name)
      child = self.class.new(name, self)
      children << child
      child
    end
  
    def children
      @children ||= []
    end
    
    def [](key)
      selected_child = children.select {|child| child.name == key }
      selected_child.size.eql?(1) ? selected_child.first : selected_child
    end
    
    def siblings
      if parent
        parent.children.reject {|child| child == self }
      end
    end
    
    def only_child?
      if parent
        siblings.empty?
      end
    end
    
    def childless?
      children.nil? || children.empty?
    end
    
    def has_children?
      !childless?
    end
  
    def ancestors
      return @ancestors if @ancestors
      @ancestors = []
      if parent
        @ancestors << parent
        parent.ancestors.each {|ancestor| @ancestors << ancestor }
      end
      @ancestors
    end

    def descendants
      return @descendants if @descendants
      @descendants = []
      if !children.empty?
        (@descendants << children).flatten!
        children.each {|descendant| @descendants << descendant.descendants }
        @descendants.flatten!   
      end
      @descendants
    end

    def depth
      ancestors.size
    end
  end
end