json.array!(@cosponsors) do |cosponsor|
  json.extract! cosponsor, :id
  json.url cosponsor_url(cosponsor, format: :json)
end
