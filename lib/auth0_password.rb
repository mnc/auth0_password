require "auth0_password/version"
require 'logger'

class Auth0Password

  LOWERCASES    = ('A'..'Z').to_a
  UPPERCASES    = ('a'..'z').to_a
  NUMBERS       = (0..9).to_a
  SPECIAL_CHARS = %w|! @ # $ % ^ & *|

  def initialize(min_length=8)
    @min_length = min_length
  end

  # TODO: policyに動的に対応する
  def generate(length)
    password_length = @min_length > length ? @min_length : length
    logger.warn("length parameter #{length} is less than min_length #{@min_length}") if @min_length > length
    required_elements = required_lowercases + required_uppercases + required_numbers + required_special_chars
    available_chars.tap do |a|
      random_elements = password_length.times.map { a.sample }
      break (required_elements + random_elements).join
    end
  end

  private

  def available_chars
    LOWERCASES + UPPERCASES + NUMBERS + SPECIAL_CHARS
  end

  def required_lowercases(size=1)
    LOWERCASES.sample(size)
  end

  def required_uppercases(size=1)
    UPPERCASES.sample(size)
  end

  def required_numbers(size=1)
    NUMBERS.sample(size)
  end

  def required_special_chars(size=1)
    SPECIAL_CHARS.sample(size)
  end

  def logger
    @logger ||= Logger.new(STDOUT)
  end
end
