class Example
    def m1
        puts "Like father"
    end
end

class ExampleChild < Example
    def m1
        super
        a = 2
        puts "like son"
    end
end

class ExampleGrandChild < ExampleChild
    def m1
        super
        x = 2
        #self.m2
        puts "like grand son"
    end
    
    def m2
        x=2
        p "toto"
        if 0<1 
            return 4+2
        else 
            x = 3
            return 4+3
        end
        m1
    end
end