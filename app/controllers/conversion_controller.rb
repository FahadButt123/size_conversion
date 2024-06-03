class ConversionController < ApplicationController

  def index; end

  def size_convert
    @converted_size = SizeConversionService.new(params).convert_size
    if @converted_size[:exception]
      render turbo_stream: turbo_stream.replace("conversion_result", partial: "conversion/error", locals: { message: @converted_size[:response] })
    else
      render turbo_stream: turbo_stream.replace("conversion_result", partial: "conversion/converted_size", locals: { converted_size: @converted_size[:response] })
    end
  end
end
