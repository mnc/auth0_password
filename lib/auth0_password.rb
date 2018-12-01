require "auth0_password/version"
require 'logger'

class Auth0Password

  LOWERCASES    = ('A'..'Z').to_a
  UPPERCASES    = ('a'..'z').to_a
  NUMBERS       = (0..9).to_a
  SPECIAL_CHARS = %w|! @ # $ % ^ & *|
  STRENGTH      = %i|excellent good fair low|

  def initialize(strength: , min_length: 8)
    @strength   = strength
    @min_length = min_length
  end

  # TODO: policyに動的に対応する
  def generate(length)
    password_length = @min_length > length ? @min_length : length
    logger.warn("length parameter #{length} is less than min_length #{@min_length}") if @min_length > length
    case @strength
    when :excellent
      excellent(password_length)
    when :good
      good(password_length)
    when :fair
      fair(password_length)
    when :low
      low(password_length)
    else
      excellent(password_length)
    end
  end

  private

  def excellent(length)
    required_elements = random_lowercase + random_uppercase + random_number + random_special_char
    (LOWERCASES + UPPERCASES + NUMBERS + SPECIAL_CHARS).tap do |a|
      random_elements = length.times.map { a.sample }
      break (required_elements + random_elements).shuffle.join
    end
  end

  def good(length)
    required_elements = random_lowercase + random_uppercase + random_number + random_special_char
    (LOWERCASES + UPPERCASES + NUMBERS + SPECIAL_CHARS).tap do |a|
      random_elements = length.times.map { a.sample }
      break (required_elements + random_elements).shuffle.join
    end
  end

  def fair(length)
    required_elements = random_lowercase + random_uppercase + random_number
    (LOWERCASES + UPPERCASES + NUMBERS).tap do |a|
      random_elements = length.times.map { a.sample }
      break (required_elements + random_elements).shuffle.join
    end
  end

  def low(length)
    (LOWERCASES + UPPERCASES + NUMBERS + SPECIAL_CHARS).tap do |a|
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
