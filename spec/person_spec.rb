require 'spec_helper'

describe Person do
  subject { Person.new }

  it "should respond to name and document" do
    should respond_to :name
    should respond_to :document
  end

  it "should generate document" do
    subject.document.should be_instance_of(Cpf)
  end

  it "should have document number" do
    subject.document_number.should eq(subject.document.to_s)
  end

  it "should generate name" do
    subject.name.should be_instance_of(String)
  end
end
