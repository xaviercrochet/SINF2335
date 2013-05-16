require 'rubygems'
require 'ruby_parser'
require 'mySexp.rb'

class ContractDSL

    def initialize()
        @name = nil #the contract name
        @liableClass = nil
        @liableMethod = nil
        @sourceFile = nil #the source file in which the class is defined
        @mySexp = nil #current sexp on which we check the contract
        @condition = nil #the application condition for require and sugest
        @singleStatement = nil #check condition on single statement or entire body
    end
    
    def contractName(aName)
        @name = aName
    end
    
    def inAClass(aClass)
        @liableClass = aClass
    end
    
    def definedIn(aSourceFile)
        @sourceFile = aSourceFile
        @mySexp = MySexp.new(RubyParser.new.parse(File.read(aSourceFile)))
    end
    
    def forAMethod(aMethod)
        @liableMethod = aMethod
    end
    
    
    def define(&block)
        res = instance_eval(&block)
    end
    
    def validLiables()
        aClass = @mySexp.getClassSexp(@liableClass.to_sym)
        if aClass == nil
            p "there exists no class #{@liableClass} in #{@sourceFile}"
            return false
        end
        method = @mySexp.getMethodSexp(@liableClass.to_sym, @liableMethod)
        if method == nil
            p "there exists no method #{@liableMethod} in the class #{@liableClass}"
            return false
        end
        return true
    end
    
    #checks if the application conditions are respected 
    #nb: must be called BEFORE require
    def inCondition(&block)
        #check if the liable class and the liable methods exist
        if not validLiables()
            return false
        end
        @condition = instance_eval(&block)
    end


    def require(&block)
        #check if the liable class and the liable methods exist
        if not validLiables()
            return false
        end
        res = instance_eval(&block)
        #the contract is respected if 
        #   the block is respected 
        #   or
        #   the block is not respected but the application 
        #   condition is not respected
        if @condition == nil
            #behaviour when no application conditions are specified
            if res
                puts "the contract #{@name} is respected"
            else
                puts "the contract #{@name} is not respected"
            end
        else
            #behaviour when application conditions are specified
            if (res and @condition) or (not @condition)
                puts "the contract #{@name} is respected"
            else
                puts "the contract #{@name} is not respected"
            end
        end
        return res
    end
    
    def neg(&block)
        res, msg = instance_eval(&block)
        return (not res)
    end
    
   
    def beginsWith(&block)
        first = @mySexp.getFirstStatement(@liableClass.to_sym, @liableMethod)
        @mySexp = first
        @singleStatement = true
        res = instance_eval(&block)
    end
    
    def endsWith(&block)
        last = @mySexp.getLastStatement(@liableClass.to_sym, @liableMethod)
        @mySexp = last
        p @mySexp
        @singleStatement = true
        res = instance_eval(&block)
    end
    
    
    def genericCheck(aType, anExpression)
        if @singleStatement
             body = @mySexp
         else
             body = @mySexp.getBody(@liableClass.to_sym, @liableMethod)
         end

        found = false;
        if body.sexp_type == aType
            if aType == :call
                found = body.sexp_body[1] == anExpression
            else
                p body.sexp_body.head
                found = body.sexp_body.head == anExpression  
            end
            if found 
                return true  
            end
        end
        #Check for nested calls
        body.deep_each do |x|
            if x.sexp_type == aType
                if aType == :call
                    found = x.sexp_body[1] == anExpression
                elsif aType == :while
                    return true
                else
                    p body.sexp_body.head
                    found = x.sexp_body.head == anExpression  
                end
                if found 
                    return true  
                end
            end
        end

        return found 
    
    end
    
    def assigns?(aVariable)
        return genericCheck(:lasgn, aVariable)
    end
    
    def calls?(aMethod)
        return genericCheck(:call, aMethod)
    end
    
    def returns?(anExpression)
        expression = RubyParser.new.parse(anExpression) 
        return genericCheck(:return, expression)
    end
    
    def doesSuperSend?()
        return genericCheck(:zsuper, nil)
    end
        
    def doesSelfSend?()
        return genericCheck(:self, nil)
    end

    def while?()
        return genericCheck(:while, nil)
    end

    
    # returns true if the liable method in the liable class is overriden
    def isOverriden?()
        found = false
        c = Object.const_get(@liableClass).new
        #check whether the method is present in the liable class or not
        if c.class.instance_methods(false).include?(@liableMethod.to_s)
            #check whether the method is defined in an ancestor or not
            c.class.ancestors.each do |a|
                if a != c.class
                    if a.instance_methods(false).include?(@liableMethod.to_s)
                        found = true
                    end
                end
            end 
        end
        return found
    end
    
    #returns true if the method aMethod is implemented in the class of the liable method
    def isImplemented?()
        c = Object.const_get(@liableClass).new
        res = c.class.instance_methods(false).include?(@liableMethod.to_s)
        return res

    end
    
    def method_missing(m, *args, &block)  
        puts "Method #{m} unknown"  
    end  
end