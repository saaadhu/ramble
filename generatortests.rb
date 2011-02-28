require 'test/unit'
load 'generator.rb'
load 'transformer.rb'
load 'parser.rb'

class GeneratorTests < Test::Unit::TestCase
	def get_generator(text)
		ast = Parser.parse text
		transformer = Transformer.new ast
		transformer.transform
		generator = Generator.new transformer
	end

	def test_direct_production
		text = "a : 'a';"
		generator = get_generator text
		generated_text = generator.generate_random 'a'
		assert_equal "a", generated_text
	end

	def test_direct_production_with_escaped_char_literal
		text = 'a : \'\r\';'
		generator = get_generator text
		generated_text = generator.generate_random 'a'
		assert_equal '\r', generated_text
	end

	def test_direct_production_with_two_terminals
		text = "a : 'a' 'b';"
		generator = get_generator text
		generated_text = generator.generate_random 'a'
		assert_equal "a b", generated_text
	end
	def test_production_with_one_non_terminal
		text = "a : b; b : 'c';"
		generator = get_generator text
		generated_text = generator.generate_random 'a'
		assert_equal "c", generated_text
	end
	def test_production_with_two_non_terminals
		text = "a : b c; b : 'b'; c : 'c';"
		generator = get_generator text
		generated_text = generator.generate_random 'a'
		assert_equal "b c", generated_text
	end
	def test_production_with_one_non_terminal_and_two_terminals
		text = "start : b '=' 'c'; b : 'b';"
		generator = get_generator text
		generated_text = generator.generate_random 'start'
		assert_equal "b = c", generated_text
	end
end
