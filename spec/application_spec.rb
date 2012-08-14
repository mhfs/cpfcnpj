# encoding: UTF-8
require 'spec_helper'

describe Sinatra::Application do
  context "Homepage" do
    before do
      visit '/'
    end

    it "should display 5 persons" do
      page.should have_css('#persons .entity',   :count => 5)
    end

    it "should display 5 companies" do
      page.should have_css('#companies .entity', :count => 5)
    end

    it "should display validation form" do
      page.should have_css('form#validate')
    end
  end

  context "Document Validation" do
    it "should require a document", :js => true do
      visit '/'
      click_button 'Vai!'

      page.should have_css('div#validate_response div.alert-notice', :text => 'Informe o CPF ou CNPJ.')
    end

    it "should complain about invalid document", :js => true do
      visit '/'
      fill_in 'document', :with => '123456'
      click_button 'Vai!'

      page.should have_css('div#validate_response div.alert-error', :text => 'Documento inválido.')
    end

    it "should accept valid CNPJ", :js => true do
      visit '/'
      fill_in 'document', :with => '24.221.361/0001-26'
      click_button 'Vai!'

      page.should have_css('div#validate_response div.alert-success', :text => 'CNPJ Válido.')
    end

    it "should accept valid CPF", :js => true do
      visit '/'
      fill_in 'document', :with => '203.850.773-27'
      click_button 'Vai!'

      page.should have_css('div#validate_response div.alert-success', :text => 'CPF Válido.')
    end
  end
end
