require 'sinatra/base'
require 'rack-flash'
require_relative 'models/cell'
require_relative 'models/game'
require_relative 'models/grid'
require_relative 'models/player'
require_relative 'models/ship'

class Battleships < Sinatra::Base
  set :views, Proc.new{File.join(root, '..', "app", "views")}
  set :public_dir, Proc.new{File.join(root, '..', "public")}
  set :public_folder, 'public'
  set :raise_errors, false
  use Rack::Session::Pool
  use Rack::Flash

  GAME = Game.new

  get '/' do
    erb :index
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    GAME.add_players
    session[:player] = GAME.player_one
    GAME.player_one.name = params[:name]
    @player = session[:player]
    @player.get_ships!
    erb :register
  end

  get '/home' do
    @player = session[:player]
    @ships_in_hand = @player.ships.select {|ship| ship.placed? == false }
    @ships_on_board = @player.ships.select {|ship| ship.placed? == true }
    erb :game
  end

  get '/place_ships' do
    @player = session[:player]
    @ships_in_hand = @player.ships.select {|ship| ship.placed? == false }
    erb :place_ships
  end

  get '/place_ships/:shipname' do
    @player = session[:player]
    @ship = @player.ships.find{|ship| ship.name == params[:shipname]}
    erb :place_ship
  end

  post '/place_ships' do
    @player = session[:player]
    @ship = @player.ships.find{|ship| ship.name == params[:ship]}
    if params[:orientation] == 'horizontal' && params[:coordinate] != nil
      @player.place_horizontal(@ship, params[:coordinate])
    elsif params[:orientation] == 'vertical' && params[:coordinate] != nil
      @player.place_vertical(@ship, params[:coordinate])
    else
      flash[:notice] = 'All fields need to be filled out!'
      redirect back
    end
    flash[:notice] = "#{@ship.name} successfully placed!"
    redirect '/home'
  end

  error do
    redirect '/home'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
