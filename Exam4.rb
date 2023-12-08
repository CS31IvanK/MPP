# frozen_string_literal: true
require 'thread'
i=0
mutex = Mutex.new
thread1 = Thread.new do
  10.times do
    mutex.synchronize do
      i += 1
      puts "i=#{i}"
    end
  end
end
thread2 = Thread.new do
  10.times do
    mutex.synchronize do
      i += 1
      puts "i=#{i}"
    end
  end
end
thread1.join
thread2.join
puts "Result: #{i}"