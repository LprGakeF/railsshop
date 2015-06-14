json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :email, :date_of_birth
  json.url customer_url(customer, format: :json)
end
