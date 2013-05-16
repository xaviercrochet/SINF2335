class Example
	attr_accessor :title
	def m1
		self.title = "Some book"
	end

	def m2
		self.title  = "Some article"
	end
end

class ExampleOverrid < Example
	def m1
		title = "Some GREAT book"
	end

	def m3
		p "i'm not overriding any methods of father"
	end

	def m2
		self.title "Some GREAT article"
	end
end
