class Cpf < Document
  def self.generate
    digits = []
    9.times { digits << rand(9) }

    2.times { digits << self.verification_digit_for(digits) }
    new(digits.join)
  end

  def valid?
    return false unless number.length == 11
    original = number.split('').map(&:to_i)
    new = original[0..8]
    2.times { new << self.class.verification_digit_for(new) }
    original == new
  end

  def to_s
    human_number
  end

  def human_number
    number =~ /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/
    "#{$1}.#{$2}.#{$3}-#{$4}"
  end

  private

  def self.increment_value(i)
    i + 1
  end
end
