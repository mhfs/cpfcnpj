class Company < Entity
  def valid?
    original = document.gsub(/[a-zA-Z\.\(\)\/\-|\s]/,'').split('').map(&:to_i)
    return false unless original.size == 14
    new = original[0..11]
    2.times { new << verification_digit_for(new) }
    original == new
  end

  private

    # generate a CNPJ
    def generate_document
      digits = []
      8.times { digits << rand(9) }
      digits += [0, 0, 0, 1]

      2.times { digits << verification_digit_for(digits) }
      format_number(digits)
    end

    def generate_name
      Faker::Company.name
    end

    def increment_value(i)
      i < 9 ? i + 1 : 2
    end

    def format_number(array)
      array.join =~ /(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/
      "#{$1}.#{$2}.#{$3}/#{$4}-#{$5}"
    end
end
