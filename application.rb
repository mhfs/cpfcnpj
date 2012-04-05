# encoding: UTF-8

$:.unshift File.dirname(__FILE__)

# Gems requires
require 'rubygems'
require 'sinatra'
require 'haml'
require 'faker'

# App requires
require 'lib/helpers'
require 'lib/entity'
require 'lib/person'
require 'lib/company'

Faker::Config.locale = "pt-br"

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
    @result = if Person.new(params[:document]).valid?
      {:status => :success, :message => "CPF Válido."}
    elsif Company.new(params[:document]).valid?
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
