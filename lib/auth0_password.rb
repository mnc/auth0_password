require "auth0_password/version"
require 'logger'

class Auth0Password

  LOWERCASES    = ('A'..'Z').to_a
  UPPERCASES    = ('a'..'z').to_a
  NUMBERS       = ('0'..'9').to_a
  SPECIAL_CHARS = %w|! @ # $ % ^ & *|
  ALL_CHARS     = LOWERCASES + UPPERCASES + NUMBERS + SPECIAL_CHARS
  DEFAULT_LENGTH = 8

  def initialize(min_length: DEFAULT_LENGTH)
    @min_length = min_length
  end

  def excellent(length=DEFAULT_LENGTH)
    rounded_up_length = roundup_length(length)
    good_password = good(rounded_up_length)
    replace_continuous_chars!(good_password)
  end

  def good(length=DEFAULT_LENGTH)
    rounded_up_length = roundup_length(length)
    required_chars = [random_lowercase, random_uppercase, random_number, random_special_char]
    ALL_CHARS.tap do |a|
      random_chars = rounded_up_length.times.map { a.sample }
      break (required_chars + random_chars).shuffle.join
    end
  end

  def fair(length=DEFAULT_LENGTH)
    rounded_up_length = roundup_length(length)
    required_chars = [random_lowercase, random_uppercase, random_number]
    (LOWERCASES + UPPERCASES + NUMBERS).tap do |a|
      random_chars = rounded_up_length.times.map { a.sample }
      break (required_chars + random_chars).shuffle.join
    end
  end

  def low(length=DEFAULT_LENGTH)
    rounded_up_length = roundup_length(length)
    ALL_CHARS.tap do |a|
      break rounded_up_length.times.map { a.sample }.join
    end
  end

  private

  def roundup_length(length)
    logger.warn("length parameter #{length} is less than min_length #{@min_length}") if @min_length > length
    @min_length > length ? @min_length : length
  end

  def replace_continuous_chars!(password)
    password.tap do |pw|
      while m = /(.)\1{2,}/.match(pw) do
        excepted_chars = ALL_CHARS - [m[1]]
        pw[m.begin(0) + 1] = excepted_chars.sample
      end
    end
  end

  def random_lowercase
    LOWERCASES.sample
  end

  def random_uppercase
    UPPERCASES.sample
  end

  def random_number
    NUMBERS.sample
  end

  def random_special_char
    SPECIAL_CHARS.sample
  end

  def logger
    @logger ||= Logger.new(STDOUT)
  end
end
