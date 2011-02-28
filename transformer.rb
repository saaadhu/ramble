class Node
	attr_accessor :syntaxNode

	def initialize(name)
		@name = name
		@children = []
	end

	def add_child(node)
		@children << node
	end

	def children
		return @children
	end

	def name
		return @name
	end
end



class Transformer
	def initialize(ast)
		@name_node_map = {}
		@ast = ast
	end

	def transform
		build_tree(@ast)
	end

	def get_expansion(rule_name)
		return @name_node_map[rule_name]
	end

	def build_tree(root)
		root.each_rule do |rule|
			root_node = Node.new rule.name			
			@name_node_map[rule.name] = root_node

			rule.get_options.each do |option_members|
				parent_node = root_node
				option_members.each do |member|
					member_node = Node.new member.name
					member_node.syntaxNode = member
					parent_node.add_child member_node
					parent_node = member_node
				end
			end
		end
	end
end

