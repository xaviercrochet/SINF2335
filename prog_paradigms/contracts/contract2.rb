c1 = ContractDSL.new
c1.define {
	contractName "Contract 2 1"
	inAClass "NotCallignPuts"
	definedIn "examples/example_not_calling_puts.rb"
	forAMethod :m1

	require {
		neg{calls? :puts}
	}
}

c2 = ContractDSL.new
c2.define {
	contractName "Contract 2 2"
	inAClass "NotCallignPuts"
	definedIn "examples/example_not_calling_puts.rb"
	forAMethod :m2

	require {
		neg{calls? :puts}
	}
}