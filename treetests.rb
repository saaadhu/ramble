require 'test/unit'
load 'transformer.rb'
load 'parser.rb'

class TreeTests < Test::Unit::TestCase
	def print (ast, indent = 1)
		puts '-' * indent << '|' << ast.class.name 
		return if !(ast.respond_to? :real_elements) || ast.real_elements.nil?

		ast.real_elements.each { |element| print(element, indent + 1) }
	end

	def process(text)
		ast = Parser.parse text
		print ast
		transformer = Transformer.new ast
		transformer.transform
		return transformer
	end

	def test_valid_tree_for_single_production_with_branching
		text = "a : 'b' | 'c';"		
		transformer = process text
		node = transformer.get_expansion 'a'
		assert_equal 'a', node.name 
		assert_equal 2, node.children.length
		assert_equal "'b'", node.children[0].name
		assert_equal "'c'", node.children[1].name
	end

	def test_valid_tree_for_three_productions
		text = "a : b c; b : 'b'; c : 'c'; "		
		transformer = process text
		node = transformer.get_expansion 'a'

		assert_equal 'a',node.name 
		assert_equal 1,node.children.length
		assert_equal "b",node.children[0].name
		assert_equal "c", (node.children[0]).children[0].name

		node = transformer.get_expansion 'b'
		assert_equal 'b', node.name
		assert_equal "'b'", node.children[0].name

	end

	def test_valid_tree_for_three_productions_with_branching
		text = "a : b c | b; b : 'b'; c : 'c'; "		
		transformer = process text
		node = transformer.get_expansion 'a'
		assert_equal 2, node.children.length
		assert_equal "b", node.children[0].name
		assert_equal "c", node.children[0].children[0].name
		assert_equal "b", node.children[1].name
	end
end
