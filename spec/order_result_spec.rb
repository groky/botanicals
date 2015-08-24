require 'spec_helper'

describe OrderResult do

  let(:flower_bundle) {
    FlowerBundle.new('R12', 'Rose', 10, 12.99)
  }

  let(:result) {
    { 10 => [flower_bundle]}
  }

  let(:order) { double(code: 'R12', quantity: 10) }

  describe '#new' do
    it 'should create a new instance' do
      OrderResult.new order, result
    end
  end

  describe '#total_cost' do
    subject(:order_result) { OrderResult.new order, result }
    it "should be the sum of all the prices of the FlowerBundle items" do
      expect(order_result.total_cost).to eql(12.99)
    end
  end

  describe 'to_s' do

    context "when the order yielded a result for Roses" do
      let(:expected_result) {
        "10 R12 $12.99\n1 X 10 $12.99\n"
      }

      subject(:order_result) { OrderResult.new order, result }

      it "should produce the correct output" do
        expect(order_result.to_s).to eql expected_result
      end
    end

    context "when the order yielded no result" do
      let(:expected_result) {
        "There are no bundle options for #{order.quantity} #{order.code}\n"
      }

      subject(:order_result) { OrderResult.new order, Hash.new }

      it "should produce the correct output" do
        expect(order_result.to_s).to eql expected_result
      end
    end
  end
end
