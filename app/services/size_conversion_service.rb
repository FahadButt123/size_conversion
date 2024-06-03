require 'csv'

class SizeConversionService
  @size_chart = nil
  def initialize(params)
    @from = params[:initial_national]&.downcase
    @to = params[:target_national]&.downcase
    @size = params[:size]
  end

  def self.size_chart
    @size_chart ||= read_csv
  end

  def self.read_csv
    file_path = Rails.root.join('public/sizing.csv')
    csv_data = CSV.read(file_path, headers: true)
    size_chart = {}
    csv_data.each do |row|
      locale = row[0]&.downcase
      next if locale.nil?
      sizes = row.fields[1..-1]&.map { |size| size&.downcase }
      size_chart[locale] = sizes
    end
    size_chart
  end

  def convert_size
    from_size = self.class.size_chart[@from]
    to_size = self.class.size_chart[@to]
    return error_handling('initial national environment') unless from_size.present?
    return error_handling('target national environment') unless to_size.present?

    size_index = from_size.index(@size)
    return error_handling('size in initial national environment') unless size_index.present?

    converted_size = to_size[size_index]
    return error_handling('converted size') if converted_size.nil?

    { response: converted_size, exception: false }
  end

  def error_handling(context)
    error_messages = {
      'initial national environment' => "Invalid initial national environment",
      'target national environment' => "Invalid target national environment",
      'size in initial national environment' => "Size not found in initial national environment",
      'converted size' => "Size not found in target national environment",
      'unknown' => "Unknown error"
    }

    message = error_messages[context] || error_messages['unknown']
    { response: message, exception: true }
  end
end