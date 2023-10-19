# frozen_string_literal: true

# 4. Напишіть програму, яка генерує випадковий пароль заданої довжини для
# користувача

def password (size)
  # all the symbols (no special)
  charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')
  res = ""
  i=0
  while i<size
    res+= charset[rand(charset.size)]
    i+=1
  end
  res
end

puts "set the size of password"
size = gets.chomp.to_i
if size == 0
  raise "Not a size"
end
puts password(size)