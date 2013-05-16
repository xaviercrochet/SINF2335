c1 = ContractDSL.new
c1.define {
	contractName "Contract 3 1"
	inAClass "ExampleDisj"
	definedIn "examples/example_disj.rb"
	forAMethod :m1

	require {
		neg {calls?(:m2) or while?}
	}
}

c2 = ContractDSL.new
c2.define {
	contractName "Contract 3 2"
	inAClass "ExampleDisj"
	definedIn "examples/example_disj.rb"
	forAMethod :m2

	require {
		neg {calls?(:m2) or while?}
	}
}

c3 = ContractDSL.new
c3.define {
	contractName "Contract 3 3"
	inAClass "ExampleDisj"
	definedIn "examples/example_disj.rb"
	forAMethod :m3

	require {
		neg {calls?(:m3) or while?}
	}
}