#!/usr/local/bin/ruby -w


load "examples/example_1.rb"
load "contractDsl.rb"
load "mySexp.rb"

#require "rubygems"
#require "ruby_parser"

mySexp = MySexp.new(RubyParser.new.parse(File.read("testChild.rb")))
#p mySexp
#p mySexp.getClassSexp(:TestChild)
#p mySexp.getMethodSexp(:TestChild, :parentMethod)
#p mySexp.getBody(:TestChild, :parentMethod)
#p mySexp.getFirstStatement(:TestChild, :parentMethod)
#p mySexp.getLastStatement(:TestChild, :parentMethod)
#p mySexp.getStatement(:TestChild, :parentMethod, 1)

load "dsl.rb"

#mySexp = MySexp.new(RubyParser.new.parse(File.read("mySexp.rb")))
#newSexp = mySexp.getBody(:MySexp, :getBody)
#p newSexp.class
#newSexp.each_sexp do |x|
#    p x
#end