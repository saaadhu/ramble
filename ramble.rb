load 'generator.rb'
load 'transformer.rb'
load 'parser.rb'

def get_generator(text)
	ast = Parser.parse text
	transformer = Transformer.new ast
	transformer.transform
	generator = Generator.new transformer
end

grammar_text = ''
File.open('grammar.y') do |f|
	grammar_text = f.read
end

class Generator
	def generate_text_for_identifier(name)
		case name
			when 'CAT' then 'Cat'
			when 'DOG' then 'Dog'
			when 'PONY' then 'Pony'
			when 'EATS' then 'eats'
			when 'GULPS' then 'gulps'
			when 'SWALLOWS' then 'swallows'
			when 'HAY' then 'hay'
			when 'FOOD' then 'food'
			when 'MILK' then 'milk'
			when 'LINEBREAK' then "\r\n"
			when 'PERIOD' then "\b."
		end
	end
end

generator = get_generator(grammar_text)
puts generator.generate_random('start')
