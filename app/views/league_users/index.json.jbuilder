json.array!(@league_users) do |league_user|
  json.extract! league_user, :id
  json.url league_user_url(league_user, format: :json)
end
