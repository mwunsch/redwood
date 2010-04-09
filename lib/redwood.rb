# The Redood module can be mixed in to give tree-like methods to an object.
# Its primary implementation is the Redwood::Node class. Its only requirement
# is that the tree-infused-object's children and parent is an object that 
# also mixes in Redwood. See Redwood::Node for the canononical representation.

module Redwood
  VERSION = "0.0.1" 
  
  def parent
    @parent
  end
  
  def name
  end
  
  def value
  end
  
  def root?
    parent.nil?
  end
  
  def leaf?
    children.empty?
  end
  
  def root
    if root?
      self
    else
      parent.root
    end
  end

  def children
    @children ||= []
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
    ancestors.size + 1
  end
  
  def unlink
    if parent
      parent.children.delete(self)
      self.instance_variable_set(:@parent, nil)
      return self
    end
  end
  
  def walk(&block)
    if block_given?
      yield self
      children.each {|child| child.walk(&block) }
    end
  end
  
  def view(content = :name)
    treeview = ''
    if parent
      treeview += parent.children.last.eql?(self) ? "`" : "|"
      treeview << "--\s"
    end
    treeview << "#{self.send(content)}"
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
        treeview << child.view(content)
        treeview << "\n" if !children.last.eql?(child)          
      end
    end
    treeview
  end
  
  autoload :FileNode, 'redwood/file'
  autoload :Node, 'redwood/node'
end