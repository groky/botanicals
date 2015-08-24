require 'spec_helper'

describe OrderProcessor do

  describe "#new" do
    context "when valid order" do
      let(:order)   { double(code: 'L09', quantity: 3) }
      it "should create a new OrderProcessor" do
        OrderProcessor.new order
      end
    end

  end

  describe "#process" do

    context "when order quantity is smaller than any bunch size" do
      let(:order)   { double }

      before do
        allow(order).to receive(:code).and_return('L09')
        allow(order).to receive(:quantity).and_return(2)
      end

      let(:subject) { OrderProcessor.new order }

      it "should produce no bundles" do
        expect(subject.process.result).to eql({})
      end
    end

    context "when order quantity is same as a bunch size" do
      let(:order)   { double }

      before do
        allow(order).to receive(:code).and_return('L09')
        allow(order).to receive(:quantity).and_return(3)
      end

      let(:subject) { OrderProcessor.new order }

      it "should produce the correct number of bundles" do
        result = subject.process.result
        expect(result.size).to eql 1
      end
    end

    context "when order quantity is greater than the smallest bunch size, but not equal to any of the bunch sizes" do
      let(:order)   { double }

      before do
        allow(order).to receive(:code).and_return('L09')
        allow(order).to receive(:quantity).and_return(8)
      end

      let(:subject) { OrderProcessor.new order }

      it "should produce no bundles" do
        expect(subject.process.result).to eql({})
      end
    end

    context "when order quantity is greater than the largest bunch size" do
      let(:order)   { double }

      before do
        allow(order).to receive(:code).and_return('L09')
        allow(order).to receive(:quantity).and_return(15)
      end

      let(:subject) { OrderProcessor.new order }

      it "should produce no bundles" do
        result = subject.process.result
        expect(result[9].size).to eql 1
        expect(result[6].size).to eql 1
      end
    end

    context "when order quantity is quite large" do
      let(:order)   { double }

      before do
        allow(order).to receive(:code).and_return('T58')
        allow(order).to receive(:quantity).and_return(23)
      end

      let(:subject) { OrderProcessor.new order }

      it "should produce no bundles" do
        result = subject.process.result
        expect(result[9].size).to eql 2
        expect(result[5].size).to eql 1
      end
    end

  end
end
