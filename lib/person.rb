class Person < Entity

  private

  def generate_doc
    Cpf.generate
  end

  def generate_name
    Faker::Name.name
  end
end
