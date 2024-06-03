class WebConversionController < ApplicationController

  def index; end

  def size_convert
    @converted_size = SizeConversionService.new(params).read_csv
    if @converted_size[:exception]
      render turbo_stream: turbo_stream.replace("conversion_result", partial: "web_conversion/error", locals: { message: @converted_size[:response] })
    else
      render turbo_stream: turbo_stream.replace("conversion_result", partial: "web_conversion/converted_size", locals: { converted_size: @converted_size[:response] })
    end
  end
end
