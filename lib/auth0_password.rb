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
    good_password = good(roundup_length(length))
    replace_continuous_chars!(good_password)
  end

  def good(length=DEFAULT_LENGTH)
    required_chars = [random_lowercase, random_uppercase, random_number, random_special_char]
    add_random_chars(ALL_CHARS, required_chars, roundup_length(length))
  end

  def fair(length=DEFAULT_LENGTH)
    required_chars = [random_lowercase, random_uppercase, random_number]
    add_random_chars(LOWERCASES + UPPERCASES + NUMBERS, required_chars, roundup_length(length))
  end

  def low(length=DEFAULT_LENGTH)
    roundup_length(length).times.map { ALL_CHARS.sample }.join
  end

  private

  def add_random_chars(chars, required_chars, length)
    additional_char_length = length - required_chars.size
    random_chars = additional_char_length.times.map { chars.sample }
    (required_chars + random_chars).shuffle.join
  end

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
