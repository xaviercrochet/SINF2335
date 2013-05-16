c = ContractDSL.new
#Contract is respected because return "42" is not the last call of m1.
c.define {
	contractName "Contract 4 1"
	inAClass "BigExample"
	definedIn "examples/example_big.rb"
	forAMethod :m1

	inCondition {
		neg{isOverriden?}
	}

	require {
		neg{endsWith{returns? "42"}} or 
		(beginsWith{calls? :puts} and assigns? :x)
	}
}
#Contract is respected beaucse m2 is calling puts and assigning variable :x
c2 = ContractDSL.new
c2.define {
	contractName "Contract 4 2"
	inAClass "BigExample"
	definedIn "examples/example_big.rb"
	forAMethod :m2

	inCondition {
		neg{isOverriden?}
	}

	require {
		neg{endsWith{returns? "42"}} or 
		(beginsWith{calls? :puts} and assigns? :x)
	}
}