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
		generated_text = generator.generate 'a'
		assert_equal "'a'", generated_text
	end
end
