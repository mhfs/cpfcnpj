require "spec_helper"

describe Cnpj do
  let(:cnpj) { Cnpj.new("12.123.123/0001-01") }

  it "should initialize by number and clean it" do
    cnpj.number.should eq("12123123000101")
  end

  it "should give humanized number" do
    cnpj.human_number.should eq("12.123.123/0001-01")
  end

  it "should to_s to humanized version" do
    cnpj.to_s.should eq("12.123.123/0001-01")
  end

  it "should validate valid CNPJ" do
    Cnpj.new('24.270.523/0001-16').should be_valid
    Cnpj.new('24270523000116').should be_valid
  end

  it "should invalidate invalid CNPJ" do
    Cnpj.new('24.270.523/0001-66').should_not be_valid
    Cnpj.new('123456').should_not be_valid
    Cnpj.new('').should_not be_valid
  end

  it "should generate random CNPJs" do
    cnpjs = []
    10.times do
      cnpj = described_class.generate
      cnpj.should be_valid
      cnpjs.should_not include(cnpj.number)
      cnpjs << cnpj.number
    end
  end
end
