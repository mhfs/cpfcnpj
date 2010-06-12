# Gems requires
require 'rubygems'
require 'sinatra'
require 'haml'
require 'faker'

# Brazillian Rails requires
require 'lib/br_rails/cpf_cnpj'
require 'lib/br_rails/cpf'
require 'lib/br_rails/cnpj'

# App requires
require 'lib/helpers'
require 'lib/entity'
require 'lib/person'
require 'lib/company'

# Set utf-8 for all the outgoing content
before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  @companies = []
  @persons   = []
  5.times do
    @companies << Company.new
    @persons   << Person.new
  end
  haml :index
end

post '/validate' do
  if params[:document].empty?
    @result = {:status => :notice, :message => "Informe o CPF ou CNPJ."}
  else
    @result = if Cpf.new(params[:document]).valido?
      {:status => :success, :message => "CPF Válido."}
    elsif Cnpj.new(params[:document]).valido?
      {:status => :success, :message => "CNPJ Válido."}
    else
      {:status => :error, :message => "Documento inválido."}
    end
  end
  haml :validate, :layout => false
end

get '/about' do
  haml :about
end