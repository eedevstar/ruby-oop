class DurationFormatter
  def initialize(duration, format = "HH:MM:SS")
    @duration = duration
    @format = format
  end

  def format_duration
    validate_duration
    return @error_message if @error_message

    hours = @duration / 3600
    minutes = (@duration % 3600) / 60
    seconds = @duration % 60

    if @format == "HH:MM"
      "%02d:%02d" % [hours, minutes]
    else
      "%02d:%02d:%02d" % [hours, minutes, seconds]
    end
  end

  private

  def validate_duration
    @error_message = nil

    if @duration.nil? || @duration.to_s.strip.empty?
      @error_message = "Duration not supplied"
      return
    end

    unless @duration.is_a?(Numeric)
      @error_message = "Duration must be a number"
      return
    end

    unless @duration.is_a?(Integer)
      @error_message = "Duration must be an integer"
      return
    end

    if @duration.negative?
      @error_message = "Duration must not be negative"
    end
  end
end