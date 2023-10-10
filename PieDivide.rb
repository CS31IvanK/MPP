# frozen_string_literal: true
def pie_division (pie, squarepieces, raisins, n, pieces, start_i, start_j)
  # function to find one piece

  i = start_i
  j = start_j
  puts "i=#{i}"
  puts "j=#{j}"
  # we need here to loop until we make all the pieces
  until n > raisins

    puts "loop for arr n=#{n}"
    puts pieces.inspect

    if pieces[n][0].nil? && pieces[n][1].nil?

      pieces[n][0] = i
      pieces[n][1] = j
      puts "Empty el" + pieces.inspect
      # n += 1
      # next

    end
    # until reached square
    until (pieces[n][0] - start_i + 1) * (pieces[n][1] - start_j + 1) == squarepieces
      puts "SQ #{(pieces[n][0] - start_i + 1) * (pieces[n][1] - start_j + 1)}"
      # check if reached the end of lines
      unless j < pie[n].length
        i += 1
        j -= 0
        unless i < pie.length
          # if end of array and not reached the square of last piece then return, false decision
          puts pieces.inspect
          puts "No more place "

          # return nil
        end
      end

      # if no extra raisins possible
      if !pie[i][j].eql?("0") || pieces[n].to_s.include?("0")
        puts "No extra raisin"
        puts pieces.inspect
        # add a pie part
        if !pieces[n].include?([i, j])
          pieces[n] = [i, j]
        end

        puts "Add a pie part"
        puts pieces.inspect
      else
        if (pieces[n][0] + 1) * (pieces[n][1] + 2) <= squarepieces
          # if there is an extra raisins on the way we change the way
          pieces[n][0] += 1
          pieces[n][1] = squarepieces / pieces[n][0] - 1
        end
      end
      j += 1
    end

    puts squarepieces
    puts " i = #{pieces[n][0]}"
    puts " j = #{pieces[n][1]}"
    n += 1
    buf = pie_division(pie, squarepieces, raisins, n, pieces, i, j)
    if buf.nil?
      puts "Way not found "
      n -= 1
      next
    end
    pieces = buf
  end

  pieces
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
height = @pie.length
# square of pie, need to divide to raisins
square = width * height
puts "WTF IS THE KILOMETER #{square}"
# if not dividing
raise "Impossible to solve" unless square % raisins == 0
# count n pieces
squarepieces = square / raisins
# now we need to use greedy algorithm to find solution
puts squarepieces
@pieces = Array.new(raisins) { Array.new(squarepieces) }
n = 0
i = 0
j = 0
@pieces = pie_division(@pie, squarepieces, raisins, n, @pieces, i, j)
puts "RESULT"
puts @pieces.inspect