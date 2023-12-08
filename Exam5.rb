# frozen_string_literal: true
def max_heap_maker(arr, n, i)
  max = i
  left = 2 * i + 1
  right = 2 * i +2
  if (left < n && arr[left] > arr[max])
    max = left
  end
  if (right < n && arr[right] > arr[max])
    max = right
  end
  if (max != i)
    swap(arr, i, max)
    max_heap_maker(arr, n, max)
  end
end

def swap (arr, i, j)
  buf = arr[i]
  arr[i] = arr[j]
  arr[j] = buf
end

def heapsorter(arr)
  n = arr.length
  for i in (n / 2 - 1).downto(0)
    max_heap_maker(arr, n, i)
  end
  for i in (n - 1).downto(1)
    swap(arr, 0, i)
    max_heap_maker(arr, i, 0)
  end
end

@numbers = []
puts "enter numbers separated with 1 space "
@numbers = gets.split(" ").map(&:to_i)
heapsorter(@numbers)
puts "Result: #{@numbers}"