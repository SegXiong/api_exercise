namespace :dev do
  task :fetch_city => :environment do
    puts "Fetch city data..."
    response = RestClient.get "http://v.juhe.cn/weather/citys", :params => { :key => JUHE_CONFIG["api_key_weather"]}
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_city = City.find_by_juhe_id(c["id"])
      if existing_city.nil?
        City.create!( :juhe_id => c["id"], :province => c["province"],
                      :city => c["city"], :district => c["district"] )

      end
    end
    puts "Total: #{City.count} cities"
  end

  task :fetch_movie => :environment do
    puts "Fetching movie data..."
    response = RestClient.get "http://v.juhe.cn/movie/movies.today", :params => { :cityid => 6, :key => JUHE_CONFIG["api_key_movie"]}
    data = JSON.parse(response.body)

    data["result"].each do |m|
      existing_movie = Movie.find_by_juhe_id(m["movieId"])
      if existing_movie.nil?
        Movie.create!( :juhe_id => m["movieId"], :name => m["movieName"], :pic => m["pic_url"])

      end
    end
    puts "Total: #{Movie.count} movies"
  end

end
