c1 = ContractDSL.new
c1.define {
    contractName "C1"
    inAClass "ExampleGrandChild"
    definedIn "examples/example_1.rb"
    forAMethod :m1
    
    #inCondition { 
    #    isOverriden?
    #}
    
    require {
       #endsWith{calls? :puts}
       #returns? "4+3"
       #assigns? :x or
       #assigns? :c
       doesSelfSend?
       #beginsWith{assigns? :x} #and 
       #assigns? :x
       #beginsWith{doesSuperSend?}
    }
}