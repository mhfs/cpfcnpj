class Cnpj < Document
  def self.generate
    digits = []
    8.times { digits << rand(9) }
    digits += [0, 0, 0, 1]

    2.times { digits << verification_digit_for(digits) }
    new(digits.join)
  end

  def valid?
    return false unless number.size == 14
    original = number.split('').map(&:to_i)
    new = original[0..11]
    2.times { new << self.class.verification_digit_for(new) }
    original == new
  end

  def to_s
    human_number
  end

  def human_number
    number =~ /(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/
    "#{$1}.#{$2}.#{$3}/#{$4}-#{$5}"
  end

  private

  def self.increment_value(i)
    i < 9 ? i + 1 : 2
  end
end
