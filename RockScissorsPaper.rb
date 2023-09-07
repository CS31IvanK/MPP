# frozen_string_literal: true
options = %w[Rock Scissors Paper]
arg = ARGV
if ARGV.empty?
  until options.casecmp(arg)
    puts("Enter Paper, Scissors or Paper")
    arg = gets.chomp
  end
end

compopt = options.sample # kompopt=computer option
puts("I choose #{compopt}")

if (arg == "Rock" && compopt == "Scissors") || (arg == "Scissors" && compopt == "Paper") || (arg == "Paper" && compopt == "Rock")
  puts("You're just the lucky one")
elsif arg == compopt
  puts("Geniuses thinking same")
else
  puts("I`m just smarter")
end

