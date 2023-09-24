# frozen_string_literal: true
class Order # context
  attr_accessor :or_state

  def initialize
    @or_state = WaitingOrderState.new(self)
  end

  def next_state
    @or_state.next
  end
end

class Order_State
  def next
    puts "Impossible"
  end

  def initialize(order)
    @order = order
  end
end

class WaitingOrderState < Order_State
  def initialize(order)
    super(order)
    puts "waiting for order"
  end

  def next
    @order.or_state= ReceivedOrderState.new(@order)
  end
end

class ReceivedOrderState < Order_State
  def initialize(order)
    super(order)
    puts "Order received"
  end

  def next
    @order.or_state = InProcessOrderState.new(@order)
  end
end

class InProcessOrderState < Order_State
  def initialize(order)
    super(order)
    puts "Order processed"
  end

  def next
    @order.or_state = ReadyOrderState.new(@order)
  end
end

class ReadyOrderState < Order_State
  def initialize(order)
    super(order)
    puts "Order ready"
  end

  def next
    @order.or_state = DeliverOrderState.new(@order)
  end
end

class DeliverOrderState < Order_State
  def initialize(order)
    super(order)
    puts "Order on the way"
  end

  def next
    @order.or_state = FinishedOrderState.new(@order)
  end
end

class FinishedOrderState < Order_State
  def initialize(order)
    super(order)
    puts "Order finished"
  end

  def next
    @order.or_state = WaitingOrderState.new(@order)
  end
end

# main?
order = Order.new
order.next_state
order.next_state
order.next_state
order.next_state
order.next_state