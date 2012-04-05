class Company < Entity
  def valid?
    original = document.gsub(/[a-zA-Z\.\(\)\/\-|\s]/,'').split('').map(&:to_i)
    return false unless original.size == 14
    new = original[0..11]
    2.times { new << verification_digit_for(new) }
    original == new
  end

  private

    def generate_document
      generate_cnpj
    end

    def generate_name
      Faker::Company.name
    end

    def generate_cnpj
      digits = []
      8.times { digits << rand(9) }
      digits += [0, 0, 0, 1]

      2.times { digits << verification_digit_for(digits) }
      format_number(digits)
    end

    def verification_digit_for(known_digits)
      i = 1
      sums = known_digits.reverse.collect do |d|
        i < 9 ? i += 1 : i = 2
        d * i
      end
      vd = 11 - sums.inject(0){|sum,item| sum + item} % 11
      vd < 10 ? vd : 0
    end

    def format_number(array)
      array.join =~ /(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/
      "#{$1}.#{$2}.#{$3}/#{$4}-#{$5}"
    end
end
