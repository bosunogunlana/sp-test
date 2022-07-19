require_relative 'transformers/default_transformer'
require_relative 'presenters/default_presenter'

class Parser
  class InvalidArgumentError < StandardError; end

  attr_accessor :filename, :transformer, :presenter

  def initialize(filename, transformer: Transformers::DefaultTransformer, presenter: Presenters::DefaultPresenter)
    raise InvalidArgumentError, 'please provide a valid log file' if filename.nil?
    raise InvalidArgumentError, 'log file does not exist' unless File.exist?(filename)

    @filename = filename
    @transformer = transformer
    @presenter = presenter
  end

  def call_all
    return call(call_type: :all)
  end

  def call_unique
    return call(call_type: :unique)
  end

  private

  def call(call_type:)
    transformed_log = transformer.call(filename, type: call_type)
    presenter.call(log_entries: transformed_log, type: call_type)
  end
end

if $0 == __FILE__
  filename = ARGV.first
  begin
    puts Parser.new(filename).call_all
    puts "------------------------------"
    puts Parser.new(filename).call_unique
  rescue Parser::InvalidArgumentError => error
    puts error.message
  end
end