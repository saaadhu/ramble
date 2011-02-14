require 'test/unit'
load 'parser.rb'

class ParseTests < Test::Unit::TestCase
	def print (ast, indent = 1)
		puts '-' * indent << '|' << ast.class.name 
		return if !(ast.respond_to? :elements) || ast.elements.nil?

		ast.elements.each { |element| print(element, indent + 1) }
	end

	def test_real_elements_in_no_branching_production
		text = 'a : b;'
		grammar = Parser.parse text
		rules = []
		grammar.each_rule {|rule| rules << rule }
		rule = rules.first

		assert_equal 'a', rule.name
	
		options = rule.get_options
		assert_equal 1, options.length

		option = options.first
		assert_equal 'b', option.first.name
	end

	def test_real_elements_in_branching_production
		text = 'a : b | c;'
		grammar = Parser.parse text
		rules = []
		grammar.each_rule {|rule| rules << rule }
		rule = rules.first

		assert_equal 'a', rule.name
	
		options = rule.get_options
		assert_equal 2, options.length

		option = options.first
		assert_equal 'b', option.first.name

		option = options[1]
		assert_equal 'c', option.first.name
	end

	def test_real_elements_multiple_non_terminals
		text = 'a : b c;'
		grammar = Parser.parse text
		rules = []
		grammar.each_rule {|rule| rules << rule }
		rule = rules.first

		assert_equal 'a', rule.name
	
		options = rule.get_options
		assert_equal 1, options.length

		option = options.first
		assert_equal 'b', option.first.name
		assert_equal 'c', option[1].name
	end

	def test_multiple_rules
		text = "a : b c; b : 'b'; c : 'c';"
		grammar = Parser.parse text
		rules = []
		grammar.each_rule {|rule| rules << rule }
		assert_equal 3, rules.length

		rule = rules.first
		assert_equal 'a', rule.name

		rule = rules[1]
		assert_equal 'b', rule.name

		rule = rules[2]
		assert_equal 'c', rule.name
	end
end
