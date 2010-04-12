require "rubygems"
require "bundler"
Bundler.setup(:development)

require 'rake'

begin
  require 'jeweler'
  $LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
  require "redwood"
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "redwood"
    gemspec.summary = "Ruby trees"
    gemspec.description = "A simple library to create and manage basic tree-esque structures."
    gemspec.version = Redwood::VERSION
    gemspec.homepage = "http://github.com/mwunsch/redwood"
    gemspec.authors = ["Mark Wunsch"]
    gemspec.email = ["mark@markwunsch.com"]
    gemspec.add_development_dependency "bundler", ">= 0.9.19"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "redwood #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r redwood"
end

desc "Build the manual"
task :build_man do
  sh "ronn -br5 --organization='Mark Wunsch' --manual='Redwood Manual' man/*.ronn"
end
 
desc "Show the manual"
task :man => :build_man do
  exec "man man/redwood.1"
end
