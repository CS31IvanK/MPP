# frozen_string_literal: true

module Rider
  def ride_a_bike
    puts "I ride a bike"
  end
  def ride_a_car
    puts "I ride a car"
  end
end
class Bike
  include Rider
end
class Car
  include Rider
end
Bike.new.ride_a_bike
Car.new.ride_a_car
