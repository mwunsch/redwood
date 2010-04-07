class Redwood
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
    end

    def add_child
    end
  
    def children
    end
    
    def siblings
    end

    def has_children?
      !childless?
    end

    def childless?
      children.nil? || children.empty?
    end
  
    def ancestors
    end

    def descendants
    end

    def depth
    end
  end
end