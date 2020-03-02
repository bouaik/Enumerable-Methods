module Enumerable
    puts "<------ MY EACH ------>"
    def my_each
        return "no block given" unless block_given?
        0.upto(self.length - 1) do |i|
            yield self[i]
        end
        self
    end
    x = [1, 5,-4, 3, 89, 11, -35]
    x.my_each do |ele|
        puts ele * 2
    end
end
