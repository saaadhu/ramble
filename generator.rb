class Generator

	def initialize(transformer)
		@transformer = transformer
	end

	def generate_random_text(node)
		return node.syntaxNode.generate if node.syntaxNode.instance_of? Yacc::CharLiteral
		actual_node = @transformer.get_expansion node.name
		if actual_node.nil?
			return generate_text_for_identifier(node.name)
		end
		text = ''
		current_node = actual_node
		while current_node && current_node.children.any? do
			current_node = current_node.children.sample
			text << whitespace << (generate_random_text current_node)
		end
		return text.strip
	end

	def generate_random(name)
		node = @transformer.get_expansion name
		generate_random_text node
	end

	def is_terminal(node)
		return (@transformer.get_expansion(node.name) == nil)
	end

	def whitespace
		return ' '
	end

	def generate_text_for_identifier(name) end
end
