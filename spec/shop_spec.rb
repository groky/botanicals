require 'spec_helper'

describe Shop do


  describe '#new' do
    it 'create a new instance' do
      shop = Shop.new

      expect(shop.close).to be false

    end
  end

  describe '#run!' do
    subject(:shop) { Shop.new }

    before do
      allow(shop).to receive(:gets).and_return("10 R12")
      allow(shop).to receive(:close).and_return(false, true)
    end

    it "should process the order" do
      expect{ shop.run! }.to_not raise_error
    end

  end
end
