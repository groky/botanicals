
#
#
#
# Produce a list of FlowerBundle(s) based on their size
#
class OrderProcessor

  attr_reader :order, :bundles, :quantity
  attr_reader :order_result, :interested_group

  def initialize(order, bundles = FlowerBundle.load_from_file)
    @order            = order
    @bundles          = bundles
    @quantity         = order.quantity

    @interested_group = bundles[order.code]
    @order_result     = Hash.new { |hash, key| hash[key] = [] }
  end

  def process
    order_result = if group_keys.min > quantity # exit early if the order quantity is smaller than the smallest bunch size
      {}
    elsif group_keys.include?(quantity) # exit early if the quantity is one of the keys
      { quantity => [ interested_group[quantity] ] }
    else
      calculate_groups(quantity, group_keys_clone)
    end

    OrderResult.new(order, order_result)
  end

  private

  def calculate_groups(order_quantity, available_bunch_sizes)

    available_bunch_sizes.each do |bunch_size|
      remainder       = order_quantity % bunch_size
      representations = (order_quantity - remainder)/bunch_size
      add_items_to_result(representations, bunch_size)

      break if completed?

      # go again
      order_quantity = remainder
    end

    completed? ? order_result : consider_recalculation
  end

  def consider_recalculation
    if group_keys.size > 0
      # we haven't exhausted our options. work our way down
      reset_calculation
      calculate_groups(quantity, group_keys_clone)
    else
      {}
    end
  end

  def group_keys_clone
    @group_keys_clone ||= group_keys.clone
  end

  def group_keys
    @group_keys ||= interested_group.keys.reverse
  end

  def add_items_to_result(count, bunch_size)
    count.times do
      order_result[bunch_size] << interested_group[bunch_size]
    end
  end

  def completed?
    number_processed == quantity
  end

  def number_processed
    order_result.inject(0) do |total, (k, v)|
      total += k * v.length
    end
  end

  def reset_calculation
    @group_keys.shift
    @group_keys_clone = nil
    @order_result = Hash.new { |hash, key| hash[key] = [] }
  end
end
