# frozen_string_literal: true
require 'thread'

class MyThreads
  def mymethod
    semaphore = Mutex.new #create semaphore(mutex object)
    condition = ConditionVariable.new #create condition variable to signal 
    currthread = 1 #variable to choose thread

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
        semaphore.synchronize do #synchronize threads
          condition.wait(semaphore) while currthread != 2 #wait for permission
          puts "Потік 2: #{i}" #print
          currthread = 1 #get other thread
          condition.signal #invoke thread1
        end
      end
    end

    th1.join
    th2.join
  end
end

MyThreads.new.mymethod
