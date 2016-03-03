json.array!(@accounts) do |account|
  json.extract! account, :id, :users_id, :number, :balance, :status
  json.url account_url(account, format: :json)
end
