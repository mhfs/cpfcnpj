class Person < Entity

  private

    def generate_document
      generate_cpf
    end

    def generate_name
      Faker::Name.name
    end

    # TODO Make it decent
    def generate_cpf
      n1 = rand(9)
      n2 = rand(9)
      n3 = rand(9)
      n4 = rand(9)
      n5 = rand(9)
      n6 = rand(9)
      n7 = rand(9)
      n8 = rand(9)
      n9 = rand(9)

      d1 = n9*2 + n8*3 + n7*4 + n6*5 + n5*6 + n4*7 + n3*8 + n2*9 + n1*10
      d1 = 11 - d1 % 11
      d1 = 0 if d1 >= 10

      d2 = d1*2 + n9*3 + n8*4 + n7*5 + n6*6 + n5*7 + n4*8 + n3*9 + n2*10 + n1*11
      d2 = 11 - d2 % 11
      d2 = 0 if d2 >= 10

      "#{n1}#{n2}#{n3}.#{n4}#{n5}#{n6}.#{n7}#{n8}#{n9}-#{d1}#{d2}"
    end

end