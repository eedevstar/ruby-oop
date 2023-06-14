require 'minitest/autorun'
require 'duration_formatter'

class DurationFormatterTest < Minitest::Test
  def test_valid_duration_with_seconds
    duration = DurationFormatter.new(3661)
    assert_equal "01:01:01", duration.format_duration
  end

  def test_valid_duration_with_over_24_hours
    duration = DurationFormatter.new(90000)
    assert_equal "25:00:00", duration.format_duration
  end

  def test_valid_duration_without_seconds
    duration = DurationFormatter.new(3661, "HH:MM")
    assert_equal "01:01", duration.format_duration
  end

  def test_duration_not_supplied
    duration = DurationFormatter.new(nil)
    assert_equal "Duration not supplied", duration.format_duration
  end

  def test_duration_not_a_number
    duration = DurationFormatter.new("not a number")
    assert_equal "Duration must be a number", duration.format_duration
  end

  def test_duration_negative
    duration = DurationFormatter.new(-1)
    assert_equal "Duration must not be negative", duration.format_duration
  end

  def test_duration_not_an_integer
    duration = DurationFormatter.new(1.5)
    assert_equal "Duration must be an integer", duration.format_duration
  end

  def test_multiple_errors_return_first_error_only
    duration = DurationFormatter.new("not a number", "invalid format")
    assert_equal "Duration must be a number", duration.format_duration
  end
end