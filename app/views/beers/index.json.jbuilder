json.array!(@beers) do |beer|
  json.extract! beer, :id, :name, :brewery, :brewyear, :size, :quantity
  json.url beer_url(beer, format: :json)
end
