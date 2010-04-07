require "rubygems"
require "bundler"
Bundler.setup(:test)

require 'test/unit'
require 'contest'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'redwood'

class Test::Unit::TestCase
end
