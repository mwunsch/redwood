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
    
    test 'add a child' do
      node = Redwood::Node.new
      assert node.children.empty?
      node.add_child(:child)
      assert_equal :child, node.children.first.name
    end
    
    test 'has children' do
      node = Redwood::Node.new
      node.add_child(:child)
      assert_equal 1, node.children.size
    end
    
    test 'lookup children by named key' do
      node = Redwood::Node.new
      child = node.add_child(:child)
      assert_equal child, node[:child]
    end
    
    test 'has siblings' do
      node = Redwood::Node.new
      child = node.add_child(:child)
      bro = node.add_child(:bro)
      sis = node.add_child(:sis)
      assert_equal 2, child.siblings.size
      assert child.siblings.include?(bro)
      assert child.siblings.include?(sis)
      assert !child.siblings.include?(child)
    end
    
    test 'is an only child' do
      parent_one = Redwood::Node.new
      parent_two = Redwood::Node.new
      parent_one.add_child(:one_child)
      parent_one.add_child(:one_bro)
      parent_two.add_child(:two_child)
      
      assert !parent_one.children.first.only_child?
      assert parent_two.children.first.only_child?
    end
    
    test 'has ancestors' do
      node = Redwood::Node.new(:parent)
      son = node.add_child(:son)
      daughter = node.add_child(:daughter)
      grandson = son.add_child(:grandson)
      greatgrandson = grandson.add_child(:greatgrandson)
      
      ancestors = greatgrandson.ancestors
      
      assert ancestors.include?(grandson)
      assert ancestors.include?(son)
      assert ancestors.include?(node)
      assert !ancestors.include?(greatgrandson)
      assert !ancestors.include?(daughter)
    end
    
    test 'has a root' do
      node = Redwood::Node.new(:parent)
      son = node.add_child(:son)
      grandson = son.add_child(:grandson)
      greatgrandson = grandson.add_child(:greatgrandson)
      
      assert_equal node, greatgrandson.root
      assert_equal node, node.root
    end
    
    test 'has descendants' do
      node = Redwood::Node.new(:parent)
      son = node.add_child(:son)
      daughter = node.add_child(:daughter)
      grandson = son.add_child(:grandson)
      granddaughter = daughter.add_child(:granddaughter)
      greatgrandson = grandson.add_child(:greatgrandson)
      
      descendants = node.descendants
      assert descendants.include?(son)
      assert descendants.include?(daughter)
      assert descendants.include?(grandson)
      assert descendants.include?(granddaughter)
      assert descendants.include?(greatgrandson)
      assert !descendants.include?(node)
    end
    
    test 'has a depth' do
      node = Redwood::Node.new(:parent)
      son = node.add_child(:son)
      daughter = node.add_child(:daughter)
      grandson = son.add_child(:grandson)
      greatgrandson = grandson.add_child(:greatgrandson)
      
      assert_equal 0, node.depth
      assert_equal daughter.depth, son.depth
      assert_equal 2, grandson.depth
      assert_equal 3, greatgrandson.depth
    end
    
    test 'has a treeview' do
      node = Redwood::Node.new(:parent)
      dog = node.add_child(:dog)
      puppy = dog.add_child(:puppy)
      son = node.add_child(:son)
      
      daughter = node.add_child(:daughter)
      grandson = son.add_child(:grandson)
      granddaughter = daughter.add_child(:granddaughter)
      granddaughter.add_child(:greatgranddaughter).add_child(:hamburger)
      daughterson = daughter.add_child(:grandson)
      daughterson.add_child(:ruuudabegh).add_child(:hotdog)
      daughterson.add_child(:watermelon).add_child(:greatgrandson)
      greatgrandson = grandson.add_child(:greatgrandson)
      greatgranddaughter = grandson.add_child(:greatgranddaughter).add_child(:strawberry)
      son.add_child(:granddaughter)
      
      puts "\n"+node.view
    end
        
  end
end
