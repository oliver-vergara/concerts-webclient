class ConcertsController < ApplicationController
  def show
    @concert = Unirest.get("http://localhost:3000/api/v1/concerts/#{params[:id]}.json").body
  end

  def index
    @concerts = Unirest.get("http://localhost:3000/api/v1/concerts.json").body
  end 

  def new

  end

  def create
    @concert = Unirest.post("#{ENV['DOMAIN']}/concerts.json", headers: {"Accept" => "application/json"}, parameters: {artist: params[:artist], genre: params[:genre], concert_date: params[:concert_date], city: params[:city], state: params[:state]}).body
    redirect_to "/concerts/#{@concert['id']}"
  end
end
    
