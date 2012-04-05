class Person < Entity
  def valid?
    clean = document.gsub(/[a-zA-Z\.\(\)\/\-|\s]/,'')
    return false unless clean.length == 11
    digits = clean[0..8].split('').collect { |d| d.to_i }
    2.times { digits << verification_digit_for(digits) }
    format_number(document) == format_number(digits)
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
      array = array.join if array.is_a?(Array)
      array =~ /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/
      "#{$1}.#{$2}.#{$3}-#{$4}"
    end
end
