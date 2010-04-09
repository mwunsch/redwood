module Redwood
  class FileNode < Node
    
    def self.scandir(dir = Dir.pwd, tree=nil)
      node = tree ? tree : self.new(dir)
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
    
    attr_reader :path
    
    def initialize(name, parent=nil)
      super
      @path = File.expand_path(name)
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