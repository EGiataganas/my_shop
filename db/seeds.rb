Product.find_or_create_by!(name: "Nike T-Shirt") do |p|
  p.description = "Men's T-Shirt in red", 
  p.price = "15.00"
end

User.find_or_create_by!(email: "example@test.com") do |u|
  u.name = "Evangelos Giataganas", 
  u.password = "12345678", 
  u.password_confirmation = "12345678"
end