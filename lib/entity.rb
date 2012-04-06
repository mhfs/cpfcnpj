class Entity
  attr_accessor :name, :document

  def initialize
    self.document = generate_doc
    self.name     = generate_name
  end

  def document_number
    document.number
  end

  private

  def generate_doc
    raise NotImplementedError
  end

  def generate_name
    raise NotImplementedError
  end
end
