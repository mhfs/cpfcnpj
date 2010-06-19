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

  context "About" do

    it "should show page" do
      visit '/about'
      page.should have_css('h2', :text => 'Sobre')
    end

  end

  context "Document Validation" do

    it "should require a document" do
      using_javascript do
        visit '/'
        click 'Vai!'

        page.should have_css('div#validate_response div.notice', :text => 'Informe o CPF ou CNPJ.')
      end
    end

    it "should complain about invalid document" do
      using_javascript do
        visit '/'
        fill_in 'document', :with => '123456'
        click 'Vai!'

        page.should have_css('div#validate_response div.error', :text => 'Documento inválido.')
      end
    end

    it "should accept valid CNPJ" do
      using_javascript do
        visit '/'
        fill_in 'document', :with => '24.221.361/0001-26'
        click 'Vai!'

        page.should have_css('div#validate_response div.success', :text => 'CNPJ Válido.')
      end
    end

    it "should accept valid CPF" do
      using_javascript do
        visit '/'
        fill_in 'document', :with => '203.850.773-27'
        click 'Vai!'

        page.should have_css('div#validate_response div.success', :text => 'CPF Válido.')
      end
    end

  end

end
