class InputHandler

  VALID_INPUT_MATCHER = /^(?<quantity>([0-9]+))\s(?<code>(R|T|L)(12|09|58))/

  class << self
    def valid?(input)
      !input.match(VALID_INPUT_MATCHER).nil?
    end
  end

  attr_reader :order, :order_processor

  def initialize(input)
    raise InvalidInputError unless InputHandler.valid?(input)
    populate_order(input)
  end

  def handle
    order_processor.process
  end

  private

  def populate_order(input)
    matched_data     = input.match(VALID_INPUT_MATCHER)
    @order           =  Order.new(matched_data[:quantity].to_i, matched_data[:code])
    @order_processor = OrderProcessor.new(order)
  end
end


class InvalidInputError < Exception; end

# Order
# container the order instructions
# receives quantity and code
class Order < Struct.new(:quantity, :code); end
