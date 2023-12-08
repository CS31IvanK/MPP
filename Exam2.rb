# frozen_string_literal: true
def funk
    x=3
    lambda { |y| y + x}
end
funk
puts funk.call(5)

def counter
    n = 0
    Proc.new { n += 1 }
end

c = counter
puts c.call
puts c.call