#!/usr/local/bin/ruby -w

require 'rubygems'
require 'ruby_parser'

class MySexp < Sexp
    attr_accessor(:sexp)
    #comment
    #returns the sexp corresponding to aClass
    def getClassSexp(aClass)
        self.each_of_type(:class) do |x|
            if x.rest.head ==aClass
                return x
            end
        end
        nil
    end
    
    #returns the sexp corresponding to aMethod in aClass
    def getMethodSexp(aClass, aMethod)
        cls = self.getClassSexp(aClass)
        cls.each_of_type(:defn) do |x|
            if x.rest.head == aMethod
                return x
            end
        end
        nil
    end
    
    #gets the sexp coresponding to the body of aMethod
    def getBody(aClass, aMethod)
        method = self.getMethodSexp(aClass, aMethod)
        method.sexp_body[2..-1]
    end
    
    
    #gets the statement stmtNum (first statement is 1)
    def getStatement(aClass, aMethod, stmtNum)
        body = self.getBody(aClass, aMethod)
        if stmtNum-1 >= 0 && stmtNum-1 < body.length
           return body[stmtNum-1]
        end
        
        nil
    end
    
    #gets the first statement of the method aMethod
    def getFirstStatement(aClass, aMethod)
        self.getBody(aClass, aMethod).head
    end

    #gets the last statement of the method aMethod
    def getLastStatement(aClass, aMethod)
        body = self.getBody(aClass, aMethod)
        body[body.length-1]
    end

end
