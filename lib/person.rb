class Person < Entity
  def valid?
    original = document.gsub(/[a-zA-Z\.\(\)\/\-|\s]/,'').split('').map(&:to_i)
    return false unless original.size == 11
    new = original[0..8]
    2.times { new << verification_digit_for(new) }
    original == new
  end

  private

    # generate a cpf
    def generate_document
      digits = []
      9.times { digits << rand(9) }

      2.times { digits << verification_digit_for(digits) }
      format_number(digits)
    end

    def generate_name
      Faker::Name.name
    end

    def increment_value(i)
      i + 1
    end

    def format_number(array)
      array.join =~ /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/
      "#{$1}.#{$2}.#{$3}-#{$4}"
    end
end
