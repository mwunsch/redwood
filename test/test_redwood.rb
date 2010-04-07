require 'helper'

class TestRedwood < Test::Unit::TestCase
  describe 'Node' do    
    test 'has a name' do
      node = Redwood::Node.new(:test)
      assert_equal :test, node.name
    end
    
    test 'can be without children' do
      node = Redwood::Node.new
      assert node.childless?
      assert !node.has_children?
    end
    
    test 'can be a root element' do
      node = Redwood::Node.new
      assert node.root?
    end
  end
end
