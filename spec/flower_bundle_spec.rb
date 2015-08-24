require 'spec_helper'

describe FlowerBundle do

  describe "#new" do
    it "shold make a new FlowerBundle" do
      FlowerBundle.new('L09', 'Lilly', 5, 6.99)
    end
  end

  describe "#load_from_file" do
    context "before loading" do
      it "should load the csv" do
        FlowerBundle.load_from_file
      end
    end

    context "after loading the pricelist" do
      let(:bundles) { FlowerBundle.load_from_file }

      it "should make an indexed list of flower bundles [L09, R12, T58]" do
        expect(bundles.size).to eql 3
      end

      it "should have the correct number of entries" do
        expect(bundles.values.flatten.inject(0){|total, list| total += list.size  }).to eql 8
      end
    end
  end
end
