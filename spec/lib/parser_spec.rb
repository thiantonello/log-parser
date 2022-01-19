require './lib/parser'
require './spec/spec_helper'

describe Parser do  
  describe "#first_line" do
    context "when the file exist" do
      subject { described_class.new("./spec/fixtures/games_test.log") }
      
      it "return the first line of the file" do
        expect(subject.first_line).to eq("  0:00 ------------------------------------------------------------\n")
      end
    end

    context "when the file does not exist" do
      subject { described_class.new("./spec/fixtures/some_random_file.log") }

      it "returns an error" do
        expect { subject.first_line }.to raise_error(Errno::ENOENT)
      end
    end
  end
end
