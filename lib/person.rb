class Person < Entity
  def valid?
    original = document.gsub(/[a-zA-Z\.\(\)\/\-|\s]/,'').split('').map(&:to_i)
    return false unless original.size == 11
    new = original[0..8]
    2.times { new << verification_digit_for(new) }
    original == new
  end

  private

    def generate_document
      generate_cpf
    end

    def generate_name
      Faker::Name.name
    end

    def generate_cpf
      digits = []
      9.times { digits << rand(9) }

      2.times { digits << verification_digit_for(digits) }
      format_number(digits)
    end

    def verification_digit_for(known_digits)
      i = 1
      sums = known_digits.reverse.collect do |d|
        i += 1
        d * i
      end
      vd = 11 - sums.inject(0){|sum,item| sum + item} % 11
      vd < 10 ? vd : 0
    end

    def format_number(array)
      array.join =~ /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/
      "#{$1}.#{$2}.#{$3}-#{$4}"
    end
end
