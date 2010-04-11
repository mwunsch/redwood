# Redwood::FileNode stores a Directory tree in a Redwood structure. 
# FileNodes respond to methods of the File class.
# eg. FileNode#chmod, FileNode#stat, etc.

module Redwood
  class FileNode < Node
    
    # Takes a path and scans the directory, creating a Redwood tree.
    def self.scandir(dir = Dir.pwd, tree=nil)
      node = tree ? tree : self.new(dir)
      if File.directory?(dir)
        Dir.foreach(dir) do |d|
          if File.directory?("#{dir}/#{d}")
            node << scandir("#{dir}/#{d}",tree) unless (d.eql?('..') || d.eql?('.'))
          else
            node.add_child("#{dir}/#{d}")
          end
        end
      else
        node.add_child(dir)
      end
      node
    end
    
    attr_reader :path
    
    def initialize(name, parent=nil)
      super
      @path = File.expand_path(name)
    end
    
    # Some information to store in the node. Defaults to the basename of the file/directory
    def value
      @value ||= basename
    end
    
    def method_missing(method, *args, &block)
      if File.respond_to?(method)
        File.send method, path
      else
        super
      end
    end
    
  end
end