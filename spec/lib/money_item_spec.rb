require 'spec_helper'

RSpec.describe MoneyItem do
  describe "initialization" do
    context "when nil is given as argument" do 
      it "raises an error" do
        expect { described_class.new(nil) }.to raise_error("cannot be nil")
      end
    end

    context "when cents_amount is less than 0" do
      it "raises an error" do
        expect { described_class.new(-25) }.to raise_error("should be greater than 0")
      end  
    end

    context "when cents_amount is not divisible by 25" do
      it "raises an error" do
        expect { described_class.new(33) }.to raise_error("should be divisible by 25")
      end
    end

    context "when cents_amount is 150" do
      it "raises an error" do
        expect { described_class.new(150) }.to raise_error("should be either cents or dollars")
      end
    end
  end

  describe "#to_s" do
    context "when cents_amount is eq 100" do
      let(:money_item) { described_class.new(100) }

      it "returns one dollar" do
        expect(money_item.to_s).to eq "1$"
      end
    end

    context "when cents_amount is less than 100" do
      let(:money_item) { described_class.new(75) }

      it "returns some amount of cents" do
        expect(money_item.to_s).to eq "75c"
      end
    end
  end
end