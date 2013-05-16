#!/usr/local/bin/ruby -w


load "examples/example_1.rb"
load "contractDsl_v2.rb"
load "mySexp.rb"
load "examples/example_overrid.rb"
load "contracts/contract1.rb"

#require "rubygems"
#require "ruby_parser"

#mySexp = MySexp.new(RubyParser.new.parse(File.read("examples/example_1.rb")))
#p mySexp
#p mySexp.getClassSexp(:TestChild)
#p mySexp.getMethodSexp(:TestChild, :parentMethod)
#p mySexp.getBody(:TestChild, :parentMethod)
#p mySexp.getFirstStatement(:TestChild, :parentMethod)
#p mySexp.getLastStatement(:Example, :m1)
#p mySexp.getStatement(:TestChild, :parentMethod, 1)

load "dsl_v2.rb"


#newSexp = mySexp.getBody(:MySexp, :getBody)
#p newSexp.class
#newSexp.each_sexp do |x|
#    p x
#end