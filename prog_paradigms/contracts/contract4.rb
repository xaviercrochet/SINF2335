c = ContractDSL.new
c.define {
	contractName "Contract 4"
	inAClass "BigExample"
	definedIn "examples/example_big.rb"
	forAMethod :m1

	inCondition {
		neg{isOverriden?}
	}

	require {
		neg{endsWith{returns? "42"}} or beginsWith{calls? :puts}
	}
}