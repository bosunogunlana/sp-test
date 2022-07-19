require 'set'
require 'transformers/default_transformer'

describe Transformers::DefaultTransformer do
  let(:log_file) { './spec/fixtures/webserver.log' }

  let(:all_processed_log) do
    {
      "/help_page/1"=>{visit_counts: 5, visitors_ip: Set["126.318.035.038", "929.398.951.889", "722.247.931.582", "646.865.545.408", "543.910.244.929"]},
      "/about"=>{visit_counts: 4, visitors_ip: Set["061.945.150.735"]},
      "/contact"=>{visit_counts: 3, visitors_ip: Set["184.123.665.067", "543.910.244.929"]},
      "/home"=>{visit_counts: 3, visitors_ip: Set["184.123.665.067", "235.313.352.950", "316.433.849.805"]}, 
      "/index"=>{visit_counts: 2, visitors_ip: Set["444.701.448.104", "316.433.849.805"]},
    }.to_a
  end

  let(:unique_processed_log) do
    {
      "/help_page/1"=>{visit_counts: 5, visitors_ip: Set["126.318.035.038", "929.398.951.889", "722.247.931.582", "646.865.545.408", "543.910.244.929"]},
      "/home"=>{visit_counts: 3, visitors_ip: Set["184.123.665.067", "235.313.352.950", "316.433.849.805"]}, 
      "/contact"=>{visit_counts: 3, visitors_ip: Set["184.123.665.067", "543.910.244.929"]},
      "/index"=>{visit_counts: 2, visitors_ip: Set["444.701.448.104", "316.433.849.805"]},
      "/about"=>{visit_counts: 4, visitors_ip: Set["061.945.150.735"]},
    }.to_a
  end

  describe '.call' do
    it 'return transformed log' do
      transformed_log = described_class.call(log_file)
      expect(transformed_log['/contact'][:visit_counts]).to eq(3)
      expect(transformed_log['/contact'][:visitors_ip]).to eq(Set['184.123.665.067', '543.910.244.929'])
    end

    it 'sort transformed logs by all page visits in descending order' do
      transformed_log = described_class.call(log_file, type: :all)
      expect(transformed_log.to_a).to eq(all_processed_log)
      expect(transformed_log.first.first).to eq('/help_page/1')
    end

    it 'sort transformed logs by unique page visits in descending order' do
      transformed_log = described_class.call(log_file, type: :unique)
      expect(transformed_log.to_a).to eq(unique_processed_log)
      expect(transformed_log.first.first).to eq('/help_page/1')
    end
  end
end
