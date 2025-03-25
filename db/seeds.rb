# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a test user
user = User.create!(
  email: "abc@gmail.com",
  password: "abc123",
  name: "Amias",
  role: "member",
  has_voted: false
)

# Create positions
positions = [
  { name: "President", max_winners: 1, priority: 1, voting_open: true },
  { name: "Treasurer", max_winners: 2, priority: 2, voting_open: true },
  { name: "Secretary", max_winners: 1, priority: 3, voting_open: true }
]

positions.each do |position_data|
  position = Position.create!(position_data)
  3.times do |i|
    position.candidates.create!(
      name: "Candidate #{i + 1}",
      qualification: ["BIST", "BSSE", "BCSC"].sample,
      photo_url: "https://via.placeholder.com/150"
    )
  end
end

puts "Seeded test data successfully!"