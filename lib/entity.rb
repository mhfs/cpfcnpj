class Entity
  attr_accessor :name, :document

  def initialize(doc = nil)
    self.document = doc.nil? ? generate_document : doc
    self.name     = generate_name
  end
end
