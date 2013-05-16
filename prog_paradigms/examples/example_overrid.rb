class Example
	attr_accessor :title
end

class ExampleOverrid < Example
	def m1
		self.title = "bouh"
	end
end

class ExampleNotOverrid
	def m1
		puts  "I'm not ovverriding a class"
	end
end
