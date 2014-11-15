json.array!(@politician_bills) do |politician_bill|
  json.extract! politician_bill, :id
  json.url politician_bill_url(politician_bill, format: :json)
end
