# The Redwood module can be mixed in to give tree-like methods to an object.
# Its primary implementation is the Redwood::Node class. Its only requirement
# is that the tree-infused-object's children and parent is an object that 
# also mixes in tree-like methods. See Redwood::Node for the canononical representation.

module Redwood
  VERSION = "0.1.0" 
  
  # This node's parent.
  def parent
    @parent
  end
  
  # Is this node the root of the tree?
  def root?
    parent.nil?
  end
  
  # Is this node a leaf node? Is this node childless?
  def leaf?
    children.nil? || children.empty?
  end
  
  # Get the root node in this tree.
  def root
    if root?
      self
    else
      parent.root
    end
  end
  
  # Get the children of this node.
  def children
    @children ||= []
  end
  
  # Get the siblings of this node. The other children belonging to this node's parent.
  def siblings
    if parent
      parent.children.reject {|child| child == self }
    end
  end
  
  # Is this node the only child of its parent. Does it have any siblings?
  def only_child?
    if parent
      siblings.empty?
    end
  end
  
  # Does this node have children? Is it not a leaf node?
  def has_children?
    !leaf?
  end
  
  # Get all of the ancestors for this node.
  def ancestors
    ancestors = []
    if parent
      ancestors << parent
      parent.ancestors.each {|ancestor| ancestors << ancestor }
    end
    ancestors
  end
  
  # Get all of the descendants of this node.
  # All of its children, and its childrens' children, and its childrens' childrens' children...
  def descendants
    descendants = []
    if !children.empty?
      (descendants << children).flatten!
      children.each {|descendant| descendants << descendant.descendants }
      descendants.flatten!   
    end
    descendants
  end
  
  # An integer representation of how deep in the tree this node is.
  # The root node has a depth of 1, its children have a depth of 2, etc.
  def depth
    ancestors.size + 1
  end
  
  # Orphan this node. Remove it from its parent node.
  def unlink
    if parent
      parent.children.delete(self)
      self.instance_variable_set(:@parent, nil)
      return self
    end
  end
  
  # Abandon all of this node's children.
  def prune
    if children
      children.each {|child| child.unlink }
    end
  end
  
  # Recursively yield every node in the tree.
  def walk(&block)
    if block_given?
      yield self
      children.each {|child| child.walk(&block) }
    end
  end
  
  # Makes a pretty string representation of the tree.
  def view(content = :name)
    treeview = ''
    if parent
      treeview += parent.children.last.eql?(self) ? "`" : "|"
      treeview << "--\s"
    end
    treeview << "#{self.send(content)}"
    if has_children?
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
  
  autoload :FileNode, 'redwood/filenode'
  autoload :Node, 'redwood/node'
end