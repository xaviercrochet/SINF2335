c = ContractDSL.new
c.define {
	contractName "Overrid Contract 1"
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

c2 = ContractDSL.new
c2. define {
	contractName "Overrid Contract 2"
	inAClass "ExampleNotOverrid"
	definedIn "examples/example_overrid.rb"
	forAMethod :m1

	inCondition {
		isOverriden?
	}

	require {
		beginsWith{doesSelfSend?}
	}
}