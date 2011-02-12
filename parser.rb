require 'treetop'

base_path = File.expand_path(File.dirname(__FILE__))
require File.join(base_path, 'nodes.rb')

class Parser
	Treetop.load 'yaccparser.treetop'
	@@parser = YaccParser.new

	def self.parse(data)
		tree = @@parser.parse data
		
		if (tree.nil?)
			raise Exception, "Parse error:#{@@parser.failure_reason} at offset #{@@parser.index}" 
		end
		return tree
	end

end
