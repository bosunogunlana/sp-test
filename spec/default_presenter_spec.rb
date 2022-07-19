require 'set'
require 'default_presenter'

describe DefaultPresenter do
  let(:transformed_log_entry) {
    { "/home"=> {
        visit_counts: 78,
        visitors_ip: Set["200.017.277.774", "061.945.150.735"]
      }
    }
  }

  describe '.call' do
    it 'formats enteries' do
      expect(described_class.call(log_entries: transformed_log_entry, type: :all)).to eq('/home 78 visits')
      expect(described_class.call(log_entries: transformed_log_entry, type: :unique)).to eq('/home 2 unique views')
    end
  end

  it 'pretty print page visits' do
    page_name, visit_details = transformed_log_entry.to_a.first
    expect(described_class.pretty_print(page_name: page_name, visit_details: visit_details, type: :all)).to eq('/home 78 visits')
  end

  it 'pretty print unique views' do
    page_name, visit_details = transformed_log_entry.to_a.first
    expect(described_class.pretty_print(page_name: page_name, visit_details: visit_details, type: :unique)).to eq('/home 2 unique views')
  end

  it 'formats outputs correctly' do
    expect(described_class.send(:format_output, :unique, '/home', 2)).to eq('/home 2 unique views')
    expect(described_class.send(:format_output, :unique, '/home', 1)).to eq('/home 1 unique view')
    expect(described_class.send(:format_output, :all, '/home', 2)).to eq('/home 2 visits')
    expect(described_class.send(:format_output, :all, '/home', 1)).to eq('/home 1 visit')
  end
end
