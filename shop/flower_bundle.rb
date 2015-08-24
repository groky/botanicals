require 'csv'

class FlowerBundle

  attr_reader :code, :flower_name, :size, :price

  class << self

    # Produces:
    # {
    #  'L09' =>
    #   {
    #      9 => <FlowerBundle code:'L09',bundle_size: 9.... >,
    #      6 => <FlowerBundle code:'L09',bundle_size: 6.... >,
    #     ...
    #   },
    #  'R12' => {...},
    #   ...
    # }

    def load_from_file(pricelist = FlowerShop::PRICELIST_PATH)
      # memoize. we don't want to read the file for every order that needs to be processed
      return bundles unless @bundles.nil?

      # initialize the bundles hash
      @bundles = Hash.new { |hash, key| hash[key] = Hash.new }

      # full path to data file
      file = File.expand_path(pricelist, File.dirname(__FILE__))

      # read the values from the CSV and populate the bundles hash
      CSV.foreach(File.open( file ), headers: true) do |row|
        add_data_to_bundle row
      end

      bundles
    end

    private
    attr_reader :bundles

    def add_data_to_bundle(row)
      code = row['code']
      size = row['size'].to_i
      bundles[code][size] = FlowerBundle.new(code, row['name'], size, row['price'].to_f)
    end

  end

  def initialize(code, flower_name, size, price)
    @flower_name = flower_name
    @code        = code
    @size        = size
    @price       = price
  end

end
