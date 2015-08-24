class OrderResult

  attr_reader :order, :result

  def initialize(order, result)
    @order  = order
    @result = result
  end

  def total_cost
    @total_cost ||= result.inject(0) do |total, (k, v)|
      total += v.map(&:price).inject(:+)
    end
  end

  def to_s
    if result.empty?
      "There are no bundle options for #{order.quantity} #{order.code}\n"
    else
      headline = "#{order.quantity} #{order.code} $#{'%.2f' % total_cost}\n"
      headline + extract_string_body
    end
  end

  private
  def extract_string_body
    result.inject("") do |body, (k, v)|
      body += "#{v.size} X #{k} $#{v.first.price}\n"
    end
  end

end
