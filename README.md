# redwood

Simple Ruby trees. Redwood is a simple implementation of a tree data structure in pure Ruby. It provides a few things:

+ The `redwood` command-line tool: like the Unix [`tree`](http://mama.indstate.edu/users/ice/tree/) tool, but in Ruby!
+ The Redwood module for basic tree-esqueness.
+ Redwood::Node class for basic tree-nodiness
+ Redwood::FileNode class for representing Directories and Files in a tree-like way.

[RDoc](http://rdoc.info/projects/mwunsch/redwood) | [Gem](http://rubygems.org/gems/redwood)

## Installation

	gem install redwood

## `redwood`

The `redwood` command-line tool attempts a pure Ruby implementation of [tree](http://man.cx/tree).

	USAGE: redwood [ OPTIONS ] [ DIRECTORY ]
	
Looks a bit like this:

	Redwood
	|-- bin
	|   `-- redwood
	|-- Gemfile
	|-- lib
	|   |-- redwood
	|   |   |-- filenode.rb
	|   |   `-- node.rb
	|   `-- redwood.rb
	|-- LICENSE
	|-- pkg
	|   `-- redwood-0.0.1.gem
	|-- Rakefile
	|-- README.md
	|-- redwood.gemspec
	`-- test
	    |-- helper.rb
	    `-- test_redwood.rb

	5 directories, 12 files
	
Help is a `redwood --help` away. See also: [redwood(1)](http://mwunsch.github.com/redwood/)

## `Redwood`

The Redwood module is a module for including/extending tree-like features on your objects. It stores nodes in an Array. The only requirement for children is that they too include/extend tree-like features.

Methods include:

	root?	 		## Is this a root node? Meaning, it has no parent.
	leaf? 			## Is this a leaf node? Meaning, is it without children?
	root  			## Get the root node in this tree.
	children 		## Get the children of this node.
	siblings		## Get this nodes siblings.
	only_child? 	## Is this node without siblings?
	has_children? 	## Does this node have children?
	ancestors 		## All of the parent nodes of this node.
	descendants 	## All of the descendant nodes of this node.
	depth 			## Integer representing how deep this node is in the tree.
					## A root node has a depth of 1, its children: 2, etc.
	unlink			## Detach this node from its parent.
	prune			## Unlink all of this node's chidren.
	walk			## Recursively yield every node in this tree to a block
	view			## Make a fancy string representation of the tree
					## as seen in the command-line tool
					
### Redwood::Node

The Redwood::Node class is a simple implementation of the Redwood module. It is a good starting point for other trees. It adds new methods:

	add_child(name)		## Add a child node. Nodes can have a #name.
	[](name)			## Lookup children node by their #name.
	<<(node)			## Add a node to this node's children.
	
#### Redwood::FileNode
	
The Redwood::FileNode class is an example use-case for Redwood, and it powers the `redwood` CLI. It stores a directory tree in a Redwood-backed structure. It has one primary method that does the magic:

	dir = Redwood::FileNode.scandir '~/Projects/Redwood'
	
That will go through the directory and build a Redwood tree. Redwood::FileNode objects have methods that correspond to the `File` class. So you can do things like `dir.directory?` or `dir.chmod`.

Now go forth and grow some Ruby-flavored trees.

## Copyright

Redwood is Copyright (c) 2010 Mark Wunsch and is licensed under the [MIT License](http://creativecommons.org/licenses/MIT/).
