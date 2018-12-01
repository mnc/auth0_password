require "auth0_password/version"
require 'logger'

class Auth0Password

  LOWERCASES    = ('A'..'Z').to_a
  UPPERCASES    = ('a'..'z').to_a
  NUMBERS       = ('0'..'9').to_a
  SPECIAL_CHARS = %w|! @ # $ % ^ & *|
  ALL_CHARS     = LOWERCASES + UPPERCASES + NUMBERS + SPECIAL_CHARS
  STRENGTH = %i|excellent good fair low|
  DEFAULT_LENGTH = 8

  def initialize(strength: , min_length: DEFAULT_LENGTH)
    @strength   = strength
    @min_length = min_length
  end

  def generate(length=DEFAULT_LENGTH)
    password_length = @min_length > length ? @min_length : length
    logger.warn("length parameter #{length} is less than min_length #{@min_length}") if @min_length > length
    if STRENGTH.include?(@strength)
      send(@strength, password_length)
    else
      logger.warn("strength #{@strength} is invalid. use excellent strength instead")
      excellent(password_length)
    end
  end

  private

  def excellent(length)
    good(length).tap do |password|
      while m = /(.)\1+/.match(password) do
        replace_char!(password, m)
      end
    end
  end

  def replace_char!(password, match_data)
    excepted_chars = ALL_CHARS - [match_data[1]]
    password[match_data.begin(0) + 1] = excepted_chars.sample
  end

  def good(length)
    required_chars = [random_lowercase, random_uppercase, random_number, random_special_char]
    ALL_CHARS.tap do |a|
      random_chars = length.times.map { a.sample }
      break (required_chars + random_chars).shuffle.join
    end
  end

  def fair(length)
    required_chars = [random_lowercase, random_uppercase, random_number]
    (LOWERCASES + UPPERCASES + NUMBERS).tap do |a|
      random_chars = length.times.map { a.sample }
      break (required_chars + random_chars).shuffle.join
    end
  end

  def low(length)
    ALL_CHARS.tap do |a|
      break length.times.map { a.sample }.join
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
