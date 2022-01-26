# frozen_string_literal: true

require './lib/parser'
require './spec/spec_helper'

describe Parser do
  let(:path) { './spec/fixtures/games_test.log' }

  describe '#initialize' do
    context 'when the file does not exist' do
      subject { described_class.new('./spec/fixtures/some_random_file.log') }

      it 'returns an error' do
        expect { subject.first_line }.to raise_error('File not found')
      end
    end
  end

  describe '#first_line' do
    subject { described_class.new(path) }

    it 'returns the first line of the file' do
      expect(subject.first_line).to eq("  0:00 ------------------------------------------------------------\n")
    end
  end

  describe '#output_json' do
    subject { described_class.new(path).output_json }

    let(:hash) do
      {
        "games_test.log": {
          "lines": 158,
          "players": [
            'Isgalamido',
            'Dono da Bola',
            'Mocinha',
            'Zeh'
          ],
          "kills": {
            "Isgalamido": 4,
            "Dono da Bola": 0,
            "Mocinha": 0,
            "Zeh": 0
          },
          "total_kills": 15
        }
      }
    end

    it { is_expected.to eq(JSON.pretty_generate(hash)) }
  end
end
