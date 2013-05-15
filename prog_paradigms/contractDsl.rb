require 'rubygems'
require 'ruby_parser'
require_relative 'mySexp.rb'

class ContractDSL

    #attr_reader :liableClass, :liableMethod, :sourceFile
    #attr_accessor :mySexp
    
    def initialize(name=nil, liableClass=nil, liableMethod=nil, sourceFile=nil, mySexp=nil)
        @name = name
        @liableClass = liableClass
        @liableMethod = liableMethod
        @sourceFile = sourceFile
        @mySexp = mySexp
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
    
    
    def require(&block)
        res, msg = instance_eval(&block)
        if res
            puts "the contract #{@name} is respected"
        else
            puts "the contract #{@name} is not respected because the condition #{msg} is not respected"
        end
    end


    #retourne true si:
    #   - la condition est vraie et le block est vrai
    # ou si:
    #   - la condition est fausse
    def condition(aStructuralCondition)

        if not aStructuralCondition[0] #[0] because we return multiple values
            return true, ""
        else
            res, msg = yield if block_given?
            return res, msg
        end
    end
    
    
    def must(&block)
        res, msg = self.instance_eval(&block)
        if not res
            #puts "the structural condition #{msg} is not respected"
            return false, msg
        else
            return true, msg
        end
    end
    
    def and!(leftProc, rightProc)
        left = leftProc.call()
        right = rightProc.call()
        
        puts (left and right)
    end
    
    #check whether the liable method in the liable class calls 
    #the method aMethod (symbol)
    def calls?(aMethod)
        body = @mySexp.getBody(@liableClass.name.to_sym, @liableMethod)
        calls = false
        #check for non nested call
        body.each_sexp do |statement|
            if statement.sexp_type == :call
                calls = statement.sexp_body[1] == aMethod
                if calls
                    return true, "calls?("+aMethod.to_s+")"
                end
            end
            #check for nested call in the current statement
            statement.deep_each do |x|
                if x.sexp_type == :call
                    calls = x.sexp_body[1] == aMethod
                    if calls
                        return true, "calls?("+aMethod.to_s+")"
                    end
                end
            end
        end
        return calls, "calls?("+aMethod.to_s+")"
    end
    
    #check whether the liable method in the liable class assigns 
    #the variable aVariable (symbol)
    def assigns?(aVariable)
        body = @mySexp.getBody(@liableClass.name.to_sym, @liableMethod)
        assigns = false
        #check for non nested assignment
        body.each_sexp do |statement|
            if statement.sexp_type == :lasgn
                assigns = statement.sexp_body.head == aVariable  
                if assigns 
                    return true, "assigns?("+aVariable.to_s+")"  
                end
            end
            #check for nested assignment
            statement.deep_each do |x|
                if x.sexp_type == :lasgn
                    assigns = x.sexp_body.head == aVariable  
                    if assigns 
                        return true, "assigns?("+aVariable.to_s+")"  
                    end
                end
            end
        end
        return assigns, "assigns?("+aVariable.to_s+")"
    end
    
    #check whether the liable method in the liable class returns 
    #the expression anExpression (string)
    def returns?(anExpression)
        body = @mySexp.getBody(@liableClass.name.to_sym, @liableMethod)
        p body
        expression = RubyParser.new.parse(anExpression)
        p expression
        returns = false;
        #check for non nested return
        body.each_sexp do |statement|
            if statement.sexp_type == :return
                returns = statement.sexp_body.head == expression 
                if returns 
                    return true, "returns?("+anExpression+")"  
                end
            end
            #check for nested return
            statement.deep_each do |x|
                if x.sexp_type == :return
                    returns = x.sexp_body.head == expression  
                    if returns 
                        return true, "returns?("+anExpression+")"
                    end
                end
            end
        end
        return returns, "returns?("+anExpression+")"
    end
    
    
    def doesSuperSend?()
        first = @mySexp.getFirstStatement(@liableClass.name.to_sym, @liableMethod.to_sym) 
        return first.sexp_type == :zsuper, "doesSuperSend?"
    end
    
    def doesSelfSend?()
        body = @mySexp.getBody(@liableClass.name.to_sym, @liableMethod)
        calls = false
        body.deep_each do |statement|
            if statement.sexp_type == :self
                return true, "doesSelfSend?"
            end
        end
        return calls, "doesSelfSend?"
    end
    
    # returns true if the liable method in the liable class is overriden
    # nb: a method is overriden in a class if this class has an instance method which 
    # is definded in an ancestors class and if this class contains a 'def' statement 
    # followed by the method name
    def isOverriden?()
        found = false
        c = @liableClass.new
        #check whether the method is present in the liable class or not
        if c.class.instance_methods(false).include?(@liableMethod.to_s)
            #check whether the method is defined in an ancestor or not
            @liableClass.ancestors.each do |a|
                if a != @liableClass
                    if a.instance_methods(false).include?(@liableMethod.to_s)
                        found = true
                    end
                end
            end 
        end
        return found, "isOverriden?"
    end
    
    #returns true if the method aMethod is implemented in the class of the liable method
    def isImplemented?()
        c = @liableClass.new
        res = c.class.instance_methods(false).include?(@liableMethod.to_s)
        return res, "isImplemented?"

    end
end
