require 'spec_helper'

RSpec.describe MoneyToString do
  describe ".humanized_from_cents" do
    context "when cents are equal or greater than 100" do 
      it "returns dollars and cents" do
        expect(described_class.humanized_from_cents(125)).to eq "1$ 25c"
      end
    end

    context "when cents are less than 100" do
      it "returns 0 dollars and some amount of cents" do
        expect(described_class.humanized_from_cents(75)).to eq "0$ 75c"
      end
    end
  end
end