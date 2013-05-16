Usage contracts for Ruby
========================
System requirements
-------------------
    - ruby 1.8.7
    - gem rubyParser 3.1.3

Launching examples
------------------
    - ruby uContracts.rb
    
Defining contracts
------------------
The contract has the following structure
        
        c= ContractDsl.new
        c.define{
            ... preamble ...
            
            inCondition{
                ...application conditions...
            }
            
            require{
                ...clauses...
            }
        }
        
    Preamble:
    ---------
    it can contains the following elements:
        - contractName "name": define the contract name
        - inAClass "className": (mandatory) define the liable class
        - definedIn "sourceFile: (mandatory) define the source file in which the class is defined
        - forAMethod :methodName: (mandatory) define the liable method
        
    Application conditions:
    -----------------------
    see clauses
    
    Clauses:
    --------       
    the following clauses are available:

        - isOverridden?: check if the liable method is overridden.
        - isImplemented?: check if the liable method is implemented.
        - doesSuperSend?: check if the liable method or statement does a super send.
        - doesSelfSend?: check if the liable method or statement does a self send.
        - calls? :method_name: check if the liable method or statement calls a specific method (symbol)
        - returns? "an_expression": check if the liable method or statement return the expression "an_expression" (string)
        - assigns? :aVariable : check if the liable method or statement assigns the specified variable (symbol)
        - while?: check if the liable method contains a "while" statement
        
    the following logical conditions are available:
        - (clause) and (clause) : conjunction of two clauses
        - (clause) or (clause) : disjunction of two clauses
        - neg { clauses }: a negation of clauses (block)
        
    the following locality conditions are available:
        - beginsWith { clauses }: check if the first statement respect the conditions defined by the clauses
        - endsWith { clauses }: check if the last statement respect the conditions defined by the clauses