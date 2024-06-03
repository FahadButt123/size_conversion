class Api::V1::ConversionController < ApplicationController
  def size_convert
    @converted_size = SizeConversionService.new(params).read_csv
    if @converted_size[:exception] == true
      render json: { message: @converted_size[:response] }, status: :unprocessable_entity
    else
      render json: { converted_size: @converted_size[:response] }, status: :ok
    end
  end
end
