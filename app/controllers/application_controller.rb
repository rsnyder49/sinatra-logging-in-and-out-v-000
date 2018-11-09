require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
      session[:id] = @user.id
      redirect to '/account'
    else 
      erb :erb
    end 
  end

  get '/account' do
    @user = User.find_by(params)
    if @user 
      erb :account 
    else 
      erb :error
    end
  end

  get '/logout' do
    session.clear 
    
    redirect to '/'
  end

end

