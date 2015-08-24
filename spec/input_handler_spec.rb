require 'spec_helper'

describe InputHandler do



  describe 'valid?' do
    context "when valid input" do
      it 'should be true' do
        input = "13 T58"
        expect(InputHandler.valid?(input)).to be true
      end
    end
    context "when invalid input" do
      it 'should be false' do
        input = "13T58"
        expect(InputHandler.valid?(input)).to be false
      end
    end
  end

  describe '#new' do

    context "when invalid input" do
      it "should raise error" do
        input = "5R12"
        expect{ InputHandler.new(input) }.to raise_error(InvalidInputError)
      end
    end

    context "when valid input" do
      let(:input)       { "10 R12" }
      subject(:handler) { InputHandler.new(input) }

      it "should create an order" do
        order = handler.order
        expect(order).to_not      be nil
        expect(order.code).to     eql('R12')
        expect(order.quantity).to eql(10)
      end
    end
  end

  # integration-style specs
  describe '#handle' do
    context "when valid input for roses" do
      let(:expected_result) {
        "10 R12 $12.99\n1 X 10 $12.99\n"
      }
      let(:input)       { "10 R12" }
      subject(:handler) { InputHandler.new(input) }

      it "should return correct output" do
        result = handler.handle
        expect(result.to_s).to eq expected_result
      end
    end
    context "when valid input for lillies" do
      let(:expected_result) {
        "15 L09 $41.90\n1 X 9 $24.95\n1 X 6 $16.95\n"
      }
      let(:input)       { "15 L09" }
      subject(:handler) { InputHandler.new(input) }

      it "should return correct output" do
        result = handler.handle
        expect(result.to_s).to eq expected_result
      end
    end

    context "when valid input for tulips" do
      let(:expected_result) {
        "13 T58 $25.85\n2 X 5 $9.95\n1 X 3 $5.95\n"
      }
      let(:input)       { "13 T58" }
      subject(:handler) { InputHandler.new(input) }

      it "should return correct output" do
        result = handler.handle
        expect(result.to_s).to eq expected_result
      end
    end
  end
end
