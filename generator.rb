class Generator
	def initialize(transformer)
		@transformer = transformer
	end

	def generate(name)
		node = @transformer.get_expansion name
		return traverse (node)
	end

	def traverse(node)
		return node.name if node.children.length == 0
		str = ''	
		node.children.each do |child|
			child_node = @transformer.get_expansion child.name
			if (child_node.nil?)
				str << child.name
			else
				str << traverse(child_node)		
			end
		end

		return str
	end
end
