module Yacc

		def self.skip_syntax_nodes element
			return element if element.class.name != 'Treetop::Runtime::SyntaxNode' 
			return nil if element.elements.nil?
			for child in element.elements
				non_syntax_node = skip_syntax_nodes child
				return non_syntax_node unless non_syntax_node.nil?
			end
			return nil
		end

	class Identifier < Treetop::Runtime::SyntaxNode
		def to_array
			return self.text_value
		end
		def generate
			return "x"
		end
	end
	class Rule < Treetop::Runtime::SyntaxNode
		def to_array
			return self.text_value
		end
	end
	class RuleBody < Treetop::Runtime::SyntaxNode
		def get_options
			options = []
			elements.each do |element|
				rule_option = Yacc::skip_syntax_nodes element
				unless rule_option.nil?
					rule_option.each_option { |option| options << option }
				end
			end
			return options
		end
	end
	class RuleElement < Treetop::Runtime::SyntaxNode
		def to_array
			return self.text_value
		end
	end
	class RuleOption < Treetop::Runtime::SyntaxNode

		def each_option
			elements.each do |element|
				element = Yacc::skip_syntax_nodes element
				if element.respond_to? :each_option
					element.each_option { |option| yield option }
				else
					target = Yacc::skip_syntax_nodes element
					yield target unless target.nil?
				end
			end
		end
	end
	class CharLiteral < Treetop::Runtime::SyntaxNode
		def to_array
			return self.text_value
		end
		def generate
			return "#{self.text_value}"
		end
	end
	class Grammar < Treetop::Runtime::SyntaxNode
		def to_array
			return self.text_value
		end
	end
end
