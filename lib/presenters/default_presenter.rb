module Presenters
  module DefaultPresenter
    SINGLE_UNIQUE_VIEW_TEXT = 'unique view'
    MULTIPLE_UNIQUE_VIEWS_TEXT = 'unique views'
    SINGLE_VISIT_TEXT = 'visit'
    MULTIPLE_VISITS_TEXT = 'visits'


    def self.call(log_entries:, type:)
      log_entries.map do |page_name, visit_details|
        pretty_print(page_name, visit_details, type)
      end.join("\n")
    end


    private_class_method def self.pretty_print(page_name, visit_details, type)
      if type == :unique
        count = visit_details[:visitors_ip].count
      else
        count = visit_details[:visit_counts]
      end

      format_output(type, page_name, count)
    end

    private_class_method def self.format_output(type, page_name, count)
      suffix =
        if type == :unique
          count > 1 ? MULTIPLE_UNIQUE_VIEWS_TEXT : SINGLE_UNIQUE_VIEW_TEXT
        else
          count > 1 ? MULTIPLE_VISITS_TEXT : SINGLE_VISIT_TEXT
        end
      return "#{page_name} #{count} #{suffix}"
    end
  end
end
