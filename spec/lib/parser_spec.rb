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

  describe '#generate_json' do
    subject { described_class.new(path).generate_json }

    let(:obj) do
      {
        "games_test.log": {
          "lines": 158,
          "players": [
            'Isgalamido',
            'Dono da Bola',
            'Mocinha',
            'Zeh'
          ]
        }
      }
    end

    it { is_expected.to eq(JSON.pretty_generate(obj)) }
  end
end
