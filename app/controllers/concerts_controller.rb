class ConcertsController < ApplicationController
    
  def show
    @concert = Concert.find(params[:id])
  end

  def index
 
    @concerts = Concert.all
    
  end 

  def new

  end

  def edit
    @concert = Concert.find(params[:id])
  end

  def create
    @concert = Unirest.post("#{ENV['DOMAIN']}/concerts.json", headers: {"Accept" => "application/json"}, parameters: {artist: params[:artist], genre: params[:genre], concert_date: params[:concert_date], city: params[:city], state: params[:state]}).body
    redirect_to "/concerts/#{@concert['id']}"
  end

  def update
    @concert = Unirest.patch("#{ENV['DOMAIN']}/concerts/#{params[:id]}.json").body
    @concert["artist"] = params[:artist] || @concert["artist"]
    @concert["genre"] = params[:genre] || @concert["genre"]
    @concert["concert_date"] = params[:concert_date] || @concert["concert_date"]
    @concert["city"] = params[:city] || @concert["city"]
    @concert["state"] = params[:state] || @concert["state"]
    redirect_to "/concerts/#{@concert['id']}"
  end

  def destroy
    @concert = Unirest.delete("#{ENV['DOMAIN']}/concerts/#{params[:id]}.json").body
    @concert.destroy
    redirect_to "/concerts"
  end  
end
    
    
