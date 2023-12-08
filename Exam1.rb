# frozen_string_literal: true

module USBChargeInterface
  def charge (phone)
  end
end
class TypeC
  include USBChargeInterface
  def charge(phone)
    puts("Charging phone...#{phone}")
  end
end
class Lightning
  def chargeIphone (iphone)
    puts("Charging iPhone...#{iphone}")
  end
end
class Adapter < Lightning
  include USBChargeInterface
  def charge(phone)
    chargeIphone(phone)
    puts "But actually it`s not iPhone..."
  end
end
puts "Charging a phone"
charger=TypeC.new.charge("Nokia")
puts "Charging a iPhone (cannot be done with a previous method without adapter)"
charger=Adapter.new.chargeIphone("Nokia")