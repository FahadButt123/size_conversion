class WebConversionController < ApplicationController

  def index; end

  def size_convert
    @converted_size = SizeConversionService.new(params).read_csv
    render json: { data: @converted_size }, status: :ok

    # render json: { converted_size: @converted_size }, status: :ok
  end

end
