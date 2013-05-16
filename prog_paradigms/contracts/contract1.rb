c = ContractDSL.new
#contract is not respected 
#beaucause m1 overide m1 method of ExampleOverrid parent
#without calling self
c.define {
	contractName "Contract 1 1"
	inAClass "ExampleOverrid"
	definedIn "examples/example_overrid.rb"
	forAMethod :m1

	inCondition {
		isOverriden?
	}

	require {
		beginsWith{doesSelfSend?}
	}
}
#contract is respected
#because m3 doesn't overide m1 method of ExampleNotOvverrid Parent
c2 = ContractDSL.new
c2. define {
	contractName "Contract 1 2"
	inAClass "ExampleOverrid"
	definedIn "examples/example_overrid.rb"
	forAMethod :m3

	inCondition {
		isOverriden?
	}

	require {
		beginsWith{doesSelfSend?}
	}
}

#contract is respected
#because :m2 overrid m2 method of his father
#and calls self at the begining of the method

c3 = ContractDSL.new
c3.define {
	contractName "Contract 1 3"
	inAClass "ExampleOverrid"
	definedIn "examples/example_overrid.rb"
	forAMethod :m2

	inCondition {
		isOverriden?
	}

	require {
		beginsWith{doesSelfSend?}
	}
}