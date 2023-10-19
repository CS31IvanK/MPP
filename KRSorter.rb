# frozen_string_literal: true

# 3. Напишіть програму, яка приймає список чисел і сортує їх у порядку зростання або
# спадання за вибором користувача.

def just_sort (array, sort_way)
  @res=[]
  begin
    case sort_way
    when 1
      @res = array.sort
    when 2
      @res = array.sort.reverse
    else
      puts "wrong input"
      return nil
    end
  end
  @res
end

@array = []
puts "enter your array, split by space"
@enter = gets.chomp
@array = @enter.split(" ")
@num = []
@array.each { |i|
  # not a rescue but anyway
  if i.to_i == 0 && !i.eql?("0")
    raise "Wrong data type"
  else
    @num << i.to_i
  end
}
puts "enter 1 to normal or 2 to reverse"
@sort_way = gets.chomp.to_i
res = just_sort(@num, @sort_way)
puts res.inspect