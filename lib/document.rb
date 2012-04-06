class Document

  attr_accessor :number

  def initialize(number)
    self.number = number.strip.gsub(/[a-zA-Z\.\(\)\/\-|\s]/,'')
  end

  def self.verification_digit_for(known_digits)
    i = 1
    sums = known_digits.reverse.collect do |d|
      i = increment_value(i)
      d * i
    end
    vd = 11 - sums.inject(0){|sum,item| sum + item} % 11
    vd < 10 ? vd : 0
  end
end
