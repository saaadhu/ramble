module Yacc
	class Treetop::Runtime::SyntaxNode
		def real_elements(children=[])
			elements.each do |element|
				if element.class.name != 'Treetop::Runtime::SyntaxNode' 
					children << element 
				elsif element.elements.nil? == false
					element.real_elements children
				end
			end
			return children
		end
	end

	class Identifier < Treetop::Runtime::SyntaxNode
		def to_array
			return self.text_value
		end
		def generate
			return "x"
		end
		def name
			return elements[0].text_value
		end
	end
	class Rule < Treetop::Runtime::SyntaxNode
		def name
			return elements[0].name
		end
		# Returns an array of arrays, one array per option
		# a : b c | d 
		# [ [b c] [d] ]
		def get_options
			rule_body = elements.find { |e| e.is_a? Yacc::RuleBody }
			return rule_body.get_options
		end
	end

	class RuleBody < Treetop::Runtime::SyntaxNode
		def get_options
			options = []
			self.each_option do |option|	
				options << option.get_members
			end
			return options
		end

		def each_option
			real_elements.each do |element|
				yield element if element.is_a? Yacc::RuleOption
			end
		end
	end
	class RuleElement < Treetop::Runtime::SyntaxNode
		def to_array
			return self.text_value
		end
	end
	class RuleOption < Treetop::Runtime::SyntaxNode
		def get_members
			members = []
			real_elements.each { |element| members << element }
			return members
		end
	end

	class CharLiteral < Treetop::Runtime::SyntaxNode
		def to_array
			return self.text_value
		end
		def generate
			return "#{self.text_value}"
		end
		def name
			return self.text_value
		end
	end
	class Grammar < Treetop::Runtime::SyntaxNode
		def to_array
			return self.text_value
		end

		def each_rule
			real_elements.each do |element|
				yield element if element.is_a? Yacc::Rule
			end
		end
	end
end
