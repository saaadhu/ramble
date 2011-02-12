load 'parser.rb'

def traverse (ast, indent=1)
	#puts '--' * indent << '>' <<  ast.class.name

	if ast.respond_to? :get_options
		ast.get_options.each { |option| puts option.generate }	
	end

	return if ast.elements.nil?	
	ast.elements.each { |element| traverse element, indent + 1 }
	
end

contents = ''
File.open('grammar.y') do |f|
	contents = f.read
end
ast = Parser.parse contents


traverse ast
