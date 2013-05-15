#if the method m1 is overriden, it must do a super send
#-->the contract is repsected because m1 is overriden and does a super send
c1 = ContractDSL.new
c1.require do
    contractName "C1"
    inAClass ExampleGrandChild
    definedIn "examples/example_1.rb"
    forAMethod :m1
    condition isOverriden? do
        must do doesSuperSend? end
    end 
end

#if the method m2 is overriden, it must do a super send
#-->the contract is respected because m2 is not overriden
c2 = ContractDSL.new
c2.require do
    contractName "C2"
    inAClass ExampleGrandChild
    definedIn "examples/example_1.rb"
    forAMethod :m2
    condition isOverriden? do
        must do doesSuperSend? end
    end 
end

#Is the method m1 implemented?
#-->the contract is respected because m1 is implemented
c3 = ContractDSL.new
c3.require do
    contractName "C3"
    inAClass ExampleGrandChild
    definedIn "examples/example_1.rb"
    forAMethod :m1
    isImplemented?
end

#Is the method m2 implemented?
#-->the contract is not respected because m2 is implemented
c4 = ContractDSL.new
c4.require do
    contractName "C4"
    inAClass ExampleGrandChild
    definedIn "examples/example_1.rb"
    forAMethod :m2
    isImplemented?
end



