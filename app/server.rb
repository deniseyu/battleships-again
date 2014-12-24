require 'sinatra/base'
require_relative 'models/cell'
require_relative 'models/game'
require_relative 'models/grid'
require_relative 'models/player'
require_relative 'models/ship'

class Battleships < Sinatra::Base
  set :views, Proc.new{File.join(root, '..', "app", "views")}
  set :public_dir, Proc.new{File.join(root, '..', "public")}
  set :public_folder, 'public'
  use Rack::Session::Pool

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

  post '/place_ships' do
    @player = session[:player]
    if params[:orientation] == 'vertical'
      @player.place_vertical(params[:ship], params[:starting_coordinate])
    else
      @player.place_horizontal(params[:ship], params[:starting_coordinate])
    end
    redirect '/game'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
