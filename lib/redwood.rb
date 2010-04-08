# The Redood module can be mixed in to give tree-like methods to an object.
# Its primary implementation is the Redwood::Node class. Its only requirement
# is that the tree-infused-object's children and parent is an object that 
# also mixes in Redwood. See Redwood::Node for the canononical representation.

module Redwood
  VERSION = "0.0.1" 
  
  def parent
    @parent
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
    ancestors.size
  end  
  
end

require 'redwood/node'