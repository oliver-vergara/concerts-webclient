class Concert

  attr_accessor :id, :artist, :genre, :schedule, :city, :state

  def initialize(hash)
    @id = hash["id"]
    @artist = hash['artist']
    @genre = hash['genre']
    @schedule = hash['schedule']
    @city = hash['city']
    @state = hash['state']
  end

  def self.find(id)
    concert_hash = Unirest.get("#{ENV['DOMAIN']}/concerts/#{id}.json").body
    return Concert.new(concert_hash)
  end

  def self.all

    concert_hashes = Unirest.get("#{ENV['DOMAIN']}/concerts.json").body
    @concerts = []
    concert_hashes.each do |hash|
      @concerts << Concert.new(hash)
    end
    return @concerts
  end

  def update(params)
    @concert = Unirest.patch("#{ENV['DOMAIN']}/concerts/#{id}.json").body
    @concert.artist = params[:artist] || @concert.artist
    @concert.genre = params[:genre] || @concert.genre
    @concert.schedule = params[:concert_date] || @concert["concert_date"]
    @concert["city"] = params[:city] || @concert["city"]
    @concert["state"] = params[:state] || @concert["state"]
    redirect_to "/concerts/#{@concert['id']}"
  end

  # def index
  #   concert_hashes = Unirest.get("#{ENV['DOMAIN']}/concerts.json").body
  #   @concerts = []
  #   concert_hashes.each do |hash|
  #     @concerts << Concert.new(hash)
  #   end
  # end


end