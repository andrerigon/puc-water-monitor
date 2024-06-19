# db/seeds.rb

puts "Seeding data..."

admin_email = 'admin@example.com'
admin_password = 'password'

admin = User.find_or_initialize_by(email: admin_email)
admin.update!(
  password: admin_password,
  password_confirmation: admin_password,
  admin: true,
  name: 'Admin User',
  phone_number: '1234567890',
  receive_updates: true
)

puts "Admin user created with email: #{admin_email} and password: #{admin_password}"

puts "Seeding completed."