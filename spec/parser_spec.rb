require 'parser'

describe Parser do
  context 'when called without log file' do
    it 'raises ArgumentError error' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end
  end

  context 'when called with invalid log file' do
    it 'raises ArgumentError error' do
      expect { described_class.new(nil) }.to raise_error(described_class::InvalidArgumentError, 'please provide a valid log file')
    end
  end

  context 'when called with non-existent log file' do
    let(:filename) { 'error.log' }

    it 'raises ArgumentError error' do
      expect { described_class.new(filename) }.to raise_error(described_class::InvalidArgumentError, 'log file does not exist')
    end
  end

  context 'when called with valid log file' do
    let(:log_file) { './spec/fixtures/webserver.log' }

    context '.call_all' do
      it 'returns all webpage ordered by visits' do
        expect(described_class.new(log_file).call_all).to eq("/help_page/1 5 visits\n/about 4 visits\n/contact 3 visits\n/home 3 visits\n/index 2 visits")
      end
    end

    context '.call_unique' do
      it 'returns webpage ordered by unique views' do
        expect(described_class.new(log_file).call_unique).to eq( "/help_page/1 5 unique views\n/home 3 unique views\n/contact 2 unique views\n/index 2 unique views\n/about 1 unique view")
      end
    end
  end
end
