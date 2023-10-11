# frozen_string_literal: true
def f (pie, pieces, square, n, raisin, starti, startj)
  #puts " start i=#{starti}, j=#{startj}"
  if square.div(pie.first.length) <= 1
    i = starti
  else
    i = square.div(pie[].length) - 1 + starti
  end
  while i < pie.length
    j = startj + (square / (i - starti + 1)) - 1
    #puts "FROM square=#{square}, i=#{i}"
    #puts "Get j=#{j}"
    flag = 0
    for iter in starti...i + 1
      for jter in startj...j + 1
        #puts pie[iter][jter]
        if pie[iter][jter].eql? "0"
          #puts "flag=#{flag}"
          flag += 1
        end
      end
    end
    if flag <= 1
      pieces[n] = [i, j]
      n += 1
      #puts "INDEED  n=#{n}, raisin=#{raisin}"
      if n == raisin
        return pieces
      end
      #puts "before count  i=#{i}, j=#{j}"
      j += 1
      unless j < pie.first.length
        i += 1
        j = 0
        #puts "NOW CHECK  i=#{i}, j=#{j}"
        unless i < pie.length

          if n == raisin # useless
            return pieces
          else
            return nil
          end
        end
      end
      #puts pieces.inspect
      #puts "n=#{n}"
      buf = f(pie, pieces, square, n, raisin, i, j)
      #puts " n=#{n}"
      if buf
        #puts "return"
        #puts pieces.inspect
        return pieces
      end
      #puts "GONE WRONG"
    end
    i += 1
  end
  #puts pieces.inspect
  nil
end

# entering & splitting
@pie = [""]
j = 0; width = 0; raisins = 0

puts "Enter pie (0 for Raisin, . for pie)"
while true
  @pie[j] = gets.chomp
  break if @pie[j].eql?("end")

  if width == 0
    width = @pie[j].length
  else
    if width != @pie[j].length
      raise "NOT A PIE, IT WAS A LIE!"
    end
  end

  @pie[j] = @pie[j].split ''
  # found out it was a useless code :(
  #@pie[j] = @pie[j].map do |x|
  #   puts x
  #  if x.eql? '.'
  #    1.to_i
  # else
  #    0.to_i
  #  end
  # end
  raisins += @pie[j].count("0")

  j += 1
end

@pie.pop
puts @pie.inspect
height = @pie.length
# square of pie, need to divide to raisins
square = width * height
# if not dividing
raise "Impossible to solve" unless square % raisins == 0
# count n pieces
squarepieces = square / raisins
# now we need to use greedy algorithm to find solution
puts "square_p=#{squarepieces}"
@pieces = Array.new(raisins) { Array.new(2) }
n = 0
i = 0
j = 0
@pieces = f(@pie, @pieces, squarepieces, n, raisins, i, j)
puts "RESULT"
puts @pieces.inspect
