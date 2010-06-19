require 'spec_helper'

describe Company do

  subject { Company.new }

  it "should respond to name and document" do
    should respond_to :name
    should respond_to :document
  end

  it "should generate valid CNPJ" do
    subject.document.length.should == 18
    subject.should be_valid
  end

  it "should create random CNPJs" do
    cnpjs = []
    10.times do
      cnpj = Company.new.document
      cnpjs.should_not include(cnpj)
      cnpjs << cnpj
    end
  end

  it "should validate valid CNPJ" do
    Company.new('24.270.523/0001-16').should be_valid
    Company.new('24270523000116').should be_valid
  end

  it "should invalidate invalid CNPJ" do
    Company.new('24.270.523/0001-66').should_not be_valid
    Company.new('123456').should_not be_valid
    Company.new('').should_not be_valid
  end

end
