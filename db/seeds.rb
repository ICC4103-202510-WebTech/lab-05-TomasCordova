# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Crear 10 usuarios
users = []
10.times do |i|
  user = User.create!(
    email: "user#{i + 1}@gmail.com",
    first_name: "firstname_user#{i + 1}",
    last_name: "lastname_user#{i + 1}"
  )
  users << user
end

# Crear 9 chats entre usuarios consecutivos
9.times do |i|
  sender = users[i]
  receiver = users[i + 1]

  chat = Chat.create!(sender_id: sender.id, receiver_id: receiver.id)

  Message.create!(chat: chat, user: sender, body: "Hi from #{sender.email}")
  Message.create!(chat: chat, user: receiver, body: "Hi back from #{receiver.email}")
end

# Último chat: usuario 10 con usuario 1
chat = Chat.create!(sender_id: users[9].id, receiver_id: users[0].id)

Message.create!(chat: chat, user: users[9], body: "Closing the circle")
Message.create!(chat: chat, user: users[0], body: "Hello again!")
