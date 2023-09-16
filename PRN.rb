def priority(operator)
  # визначимо приорітетність оператора
  puts"Objection"
  case operator
  when "+", "-"
    1
  when "*", "/"
    2
  when "^"
    3
  else
    0
  end
end

puts "Enter your expression"
$user_expression = gets.chomp.delete(' ')
$output = []
$stack = []
$user_expression.each_char do |ch| # сh= char
  if %w[+ - * / ^].include? ch
    while $stack.any? &&  priority(ch) <= priority($stack.last)
      output << $stack.pop
    end
    $stack << ch
  elsif ch == '('
    $stack << ch
  elsif ch == ')'
    until $stack.last.eql?('(')
      output << $stack.pop
    end
    $stack.pop
  else
    $output.push(ch)   # якщо не операція, вважаємо числом чи змінною
  end
end
while $stack.any?
  output << $stack.pop # переносимо з стеку на вихід
end
puts(output.join(' ')) #виводимо з пробілами для читабельності

