module Redwood
  class Node
    include Redwood
    
    def self.scandir(dir = Dir.pwd, tree=nil)
      node = tree ? tree : self.new(File.basename(dir))
      if File.directory?(dir)
        Dir.foreach(dir) do |d|
          if File.directory?("#{dir}/#{d}")
            node << scandir("#{dir}/#{d}",tree) unless (d.eql?('..') || d.eql?('.'))
          else
            node.add_child(d)
          end
        end
      else
        node.add_child(dir)
      end
      node
    end
    
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