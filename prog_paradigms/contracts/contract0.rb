c1 = ContractDSL.new
#Contract fails because there is no self call in m1
c1.define {
    contractName "Contract 0"
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