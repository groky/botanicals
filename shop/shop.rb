Dir[File.expand_path(File.join(File.dirname(__FILE__),'..','shop','**','*.rb'))].each { |f| require f }

class Shop

  attr_reader :close, :source

  def initialize
    @close  = false
    @source = $stdin
  end

  def run!

    print welcome_message

    loop do
      input = gets.chomp.strip

      break if close || input =~ /QUIT/
      begin
        print InputHandler.new(input).handle
      rescue(InvalidInputError)
        print valid_input_message
      end
    end
  end

  def close!
    @close = true
  end

  private

  def gets
    source.gets
  end

  def welcome_message
<<-EOF
--------------Flower Shop Inc.-----------------
Welcome to the Flower Shop.
To place your orders, please input valid orders.
Valid codes are:
R12 - for Roses
L09 - for Lillies
T58 - for Tulips

Type: QUIT to exit the program

The format of your message should be:
<quantity> <code>
eg, 22 T58

*Note the space between the quantity and the code. This is essential.
-----------------------------------------------
EOF
  end

  def valid_input_message
<<-EOF
----------------INVALID INPUT------------------
Valid codes are:
R12 - for Roses
L09 - for Lillies
T58 - for Tulips

The format of your message should be:
<quantity> <code>
eg, 22 T58

*Note the space between the quantity and the code. This is essential.
-----------------------------------------------
EOF
  end
end
