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

  describe "#count_lines" do
    subject { described_class.new("./spec/fixtures/games_test.log") }

    it "returns the number of lines in the file" do
      expect(subject.count_lines).to eq(158)
    end

    #verificar com os avaliadores/reviwers qual modo usar para testar o count_lines (de cima ou de baixo)

    it { expect(subject.count_lines).to eq(158)}
  end

  describe "#count_lines_json" do
    subject { described_class.new("./spec/fixtures/games_test.log") }

    let(:obj) { { "games_test.log" => {
      "lines" => 158
    } } }
    
    specify { expect(JSON.parse(subject.count_lines_json)).to eq(obj) }
    
    #verificar com os avaliadores/reviewers qual modo usar para testar o count_lines_json (de cima ou de baixo)
    
    it { expect(subject.count_lines_json).to eq(JSON.pretty_generate(obj)) }
  end
end
