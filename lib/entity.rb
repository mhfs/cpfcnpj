class Entity
  attr_accessor :name, :document

  def initialize
    self.document = generate_document
    self.name     = generate_name
  end
end