module DefaultPresenter
  def self.call(log_entries:, type:)
    log_entries.map do |page_name, visit_details|
      pretty_print(page_name: page_name, visit_details: visit_details, type: type)
    end.join("\n")
  end

  def self.pretty_print(page_name:, visit_details:, type: :all)
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
      count > 1 ? 'unique views' : 'unique view'
    else
      count > 1 ? 'visits' : 'visit'
    end
    return "#{page_name} #{count} #{suffix}"
  end
end
