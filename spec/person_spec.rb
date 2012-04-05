require 'spec_helper'

describe Person do
  subject { Person.new }

  it "should respond to name and document" do
    should respond_to :name
    should respond_to :document
  end

  it "should generate valid CPF" do
    subject.document.length.should == 14
    subject.should be_valid
  end

  it "should create random CPFs" do
    cpfs = []
    10.times do
      cpf = Person.new.document
      cpfs.should_not include(cpf)
      cpfs << cpf
    end
  end

  it "should validate valid CPF" do
    Person.new('082.424.648-98').should be_valid
    Person.new('08242464898').should be_valid
  end

  it "should invalidate invalid CPF" do
    Person.new('082.424.648-XX').should_not be_valid
    Person.new('123456').should_not be_valid
    Person.new('').should_not be_valid
  end
end
