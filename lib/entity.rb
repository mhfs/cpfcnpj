class Entity
  attr_accessor :name, :document

  def initialize(doc = nil)
    self.document = doc.nil? ? generate_document : doc
    self.name     = generate_name
  end

  private
    def verification_digit_for(known_digits)
      i = 1
      sums = known_digits.reverse.collect do |d|
        i = increment_value(i)
        d * i
      end
      vd = 11 - sums.inject(0){|sum,item| sum + item} % 11
      vd < 10 ? vd : 0
    end
end
