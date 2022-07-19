require 'set'

module Transformers
  module DefaultTransformer
    def self.call(log_file, type: :all)
      transformed_log = process(log_file)
      return sort_by_unique_visits(transformed_log) if type == :unique

      sort_by_all_visits(transformed_log)
    end

    private_class_method def self.sort_by_all_visits(logs)
      logs.sort_by { |_key, value| -value[:visit_counts] }.to_h
    end

    private_class_method def self.sort_by_unique_visits(logs)
      logs.sort_by { |_key, value| -value[:visitors_ip].count }.to_h
    end

    private_class_method def self.process(log_file)
    transformed_log = Hash.new { |hash, key| hash[key] = {visit_counts: 0, visitors_ip: Set.new} }

      File.foreach(log_file) do |log_line|
        page_name, visitor_ip = log_line.split

        transformed_log[page_name][:visit_counts] += 1
        transformed_log[page_name][:visitors_ip] << visitor_ip
      end

      transformed_log
    end
  end
end
