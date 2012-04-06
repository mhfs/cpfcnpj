require 'spec_helper'

describe Cpf do
  let(:cpf) { Cpf.new("123.123.123-12") }

  it "should initialize by number and clean it" do
    cpf.number.should eq("12312312312")
  end

  it "should give humanized number" do
    cpf.human_number.should eq("123.123.123-12")
  end

  it "should to_s to humanized version" do
    cpf.to_s.should eq("123.123.123-12")
  end

  it "should validate valid CPF" do
    Cpf.new('082.424.648-98').should be_valid
    Cpf.new('08242464898').should be_valid
  end

  it "should invalidate invalid CPF" do
    Cpf.new('082.424.648-XX').should_not be_valid
    Cpf.new('123456').should_not be_valid
    Cpf.new('').should_not be_valid
  end

  it "should generate random CPFs" do
    cpfs = []
    10.times do
      cpf = Cpf.generate
      cpf.should be_valid
      cpfs.should_not include(cpf.number)
      cpfs << cpf.number
    end
  end
end
