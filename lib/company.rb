class Company < Entity

  private

  def generate_doc
    Cnpj.generate
  end

  def generate_name
    Faker::Company.name
  end
end
