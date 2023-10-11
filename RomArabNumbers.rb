# frozen_string_literal: true
class ChangeNum
  #stupid but works
  ChangeNum = {
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  def self.to_roman(number)
    return '' if number == 0
    ChangeNum.each do |value, letter|
      return (letter * (number / value)) << to_roman(number % value) if value <= number
    end
  end

  def self.to_decimal(roman)
    return 0 if roman.empty?
    ChangeNum.each do |value, letter|
      return value + to_decimal(roman.slice(letter.length, roman.length)) if roman.start_with? letter
    end
  end
end

puts 'Введіть число для перетворення:'
str = gets.chomp

if str =~ /\A\d+\z/
  puts ChangeNum.to_roman(str.to_i)
elsif str =~ /\A[MDCLXVI]+\z/i
  puts ChangeNum.to_decimal(str.upcase)
else
  puts 'Некоректне введення. Введіть римське або десяткове число.'
end
