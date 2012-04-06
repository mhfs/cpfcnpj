require 'spec_helper'

describe Company do
  subject { Company.new }

  it "should respond to name and document" do
    should respond_to :name
    should respond_to :document
  end

  it "should generate document" do
    subject.document.should be_instance_of(Cnpj)
  end

  it "should have document number" do
    subject.document_number.should eq(subject.document.to_s)
  end

  it "should generate name" do
    subject.name.should be_instance_of(String)
  end
end
