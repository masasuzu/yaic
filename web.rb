# coding: utf-8
require 'sinatra/base'
require 'erb'
require './gmail_client'

class Web < Sinatra::Base
  include ERB::Util
  enable :sessions

  get '/' do
    if ! session["address"] and ! session["password"]
      redirect '/login'
    end

    client = GmailClient.new
    @mails = client.list_new_mail
    erb :index
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    session["address"]  = params[:address]
    session["password"] = params[:password]
    redirect '/'
  end

  get '/todo' do
    session["count"] ||= 0
    session["count"] += 1
    puts session["count"]

    @todo = [
      'css',
      'おーとぺーじゃー',
      '表示させたら既読にする',
      '未読にする',
      'layout',
    ]
    erb :todo
  end
end


