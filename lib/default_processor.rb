require 'set'

module DefaultProcessor
  def self.call(log_file, type: :all)
    processed_log = process_log(log_file)
    return sort_by_unique_visits(processed_log) if type == :unique

    sort_by_all_visits(processed_log)
  end

  private_class_method def self.sort_by_all_visits(logs)
    logs.sort_by { |key, value| -value[:visit_counts] }.to_h
  end

  private_class_method def self.sort_by_unique_visits(logs)
    logs.sort_by { |key, value| -value[:visitors_ip].count }.to_h
  end

  private_class_method def self.process_log(log_file)
    processed_log = Hash.new { |hash, key| hash[key] = {visit_counts: 0, visitors_ip: Set.new} }

    File.foreach(log_file) do |log_line|
      page_name, visitor_ip = log_line.split(' ')
      processed_log[page_name][:visit_counts] += 1
      processed_log[page_name][:visitors_ip] << visitor_ip
    end

    processed_log
  end
end
