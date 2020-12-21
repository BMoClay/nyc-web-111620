# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying all Instances"
User.destroy_all
Movie.destroy_all
WatchList.destroy_all

[1,2,3,4,5].each do |num|
  res = RestClient.get("https://api.themoviedb.org/3/discover/movie?page=#{num}&api_key=#{ENV['MOVIE_API']}")
  res_body = res.body
  movies = JSON.parse(res_body)


  genres = ["Action", "Romance", "Comedy"]

  movies["results"].each do |movie|
    Movie.create(
      title: movie["title"], 
      vote_average: movie["vote_average"], 
      vote_count: movie["vote_count"],
      overview: movie["overview"], 
      img_url: "https://image.tmdb.org/t/p/w500/#{movie['poster_path']}", 
      release_year: movie["release_date"].split("-")[0].to_i,
      genre: genres.sample
      )
  end 

end 

puts "Creating Humans 👨‍👨‍👧‍👦"
30.times do 
  User.create(name: Faker::FunnyName.name, user_name: Faker::Games::Pokemon.name, age: rand(1..100))
end 

puts "Creating Watch Lists 🍿"
200.times do 
  WatchList.create(user_id: User.all.sample.id, movie_id: Movie.all.sample.id)
end 