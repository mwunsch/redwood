module Redwood
  class Node
    include Redwood
    
    attr_reader :name
    
    def initialize(name=nil, parent=nil)
      @name = name
      @parent = parent
    end
    
    # Creates a child, adds it to children, and returns the child
    def add_child(name)
      child = self.class.new(name, self)
      children << child
      child
    end
    
    def [](key)
      selected_child = children.select {|child| child.name == key }
      selected_child.size.eql?(1) ? selected_child.first : selected_child
    end
    
    def view(content = name)
      treeview = ''
      if parent
        treeview += parent.children.last.eql?(self) ? "`" : "|"
        treeview << "--\s"
      end
      treeview << "#{content}"
      if !children.empty?
        treeview << "\n"
        children.each do |child|
          if parent
            child.ancestors.reverse_each do |ancestor|
              if !ancestor.root?
                if ancestor.only_child? || ancestor.parent.children.last.eql?(ancestor)
                  treeview << "\s\s\s\s"
                else
                  treeview << "|\s\s\s"
                end                
              end
            end       
          end
          treeview << child.view    
          treeview << "\n" if !children.last.eql?(child)          
        end
      end
      treeview
    end
    
  end
end