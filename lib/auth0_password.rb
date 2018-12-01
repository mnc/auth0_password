require "auth0_password/version"

class Auth0Password

  LOWERCASES    = ('A'..'Z').to_a
  UPPERCASES    = ('a'..'z').to_a
  NUMBERS       = (0..9).to_a
  SPECIAL_CHARS = %w|! @ # $ % ^ & *|

  def initialize(length=8)
    @length = length
  end

  # TODO: policyに動的に対応する
  def generate
    required_elements = required_lowercases + required_uppercases + required_numbers + required_special_chars
    available_chars.tap do |a|
      random_elements = @length.times.map { a.sample }
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
end
