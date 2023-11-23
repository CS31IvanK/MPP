# frozen_string_literal: true
require 'thread'

class MyThreads
  def mymethod
    semaphore = Mutex.new
    condition = ConditionVariable.new
    currthread = 1

    th1 = Thread.new do
      for i in 1..10 do
        semaphore.synchronize do
          condition.wait(semaphore) while currthread != 1
          puts "Потік 1: #{i}"
          currthread = 2
          condition.signal
        end
      end
    end

    th2 = Thread.new do
      for i in 1..10 do
        semaphore.synchronize do
          condition.wait(semaphore) while currthread != 2
          puts "Потік 2: #{i}"
          currthread = 1
          condition.signal
        end
      end
    end

    [th1, th2].each(&:join)
  end
end

MyThreads.new.mymethod
