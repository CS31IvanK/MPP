# frozen_string_literal: true
def ipv4?(adress)
  @checker = adress.split(".")
  return false unless @checker.size==4
  @checker.each { |i|
    unless (i.to_i.between?(0,255)&& i==i.to_i.to_s)
      return false
    end
  }
  true
end

puts( "Enter classic IPv4 " )
ip= gets.chomp
if ipv4?(ip)==true
  puts "yes, it is ipv4"
else
  puts "no ipv4("
end