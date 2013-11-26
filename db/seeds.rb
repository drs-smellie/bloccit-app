require 'faker'

# Create 30 topics
topics = []
30.times do
  topics << Topic.create(
    name: Faker::Lorem.words(rand(1..10)).join(" "),
    description: Faker::Lorem.paragraph(rand(1..4))
  )
end

rand(4..10).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
    name: Faker::Name.name, 
    email: Faker::Internet.email, 
    password: password, 
    password_confirmation: password)
  u.skip_confirmation!
  u.save
  
  # Note: by calling `User.new` instead of `create`,
  # we create an instance of a user which isn't saved to the database.
  # The `skip_confirmation!` method sets the confirmation date
  # to avoid sending an email. The `save` method updates the database.

  rand(20..29).times do
    topic = topics.first # getting the first topic here
    p = u.posts.create(
      topic: topic,
      title: Faker::Lorem.words(rand(1..10)).join(" "), 
      body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
    # set the created_at to a time within the past year
    p.update_attribute(:created_at, Time.now - rand(600..31536000))
    p.update_rank

    topics.rotate! # add this line to move the first topic to the last, so that posts get assigned to different topics.


  rand(3..7).times do
    p.comments.create(
      body: Faker::Lorem.paragraphs(rand(1..2)).join("\n"))
    end
  end
end

u = User.new(
  name: 'Admin User Melanie',
  email: 'melanie.keatley@gmail.com', 
  password: 'bloccit1', 
  password_confirmation: 'bloccit1')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'admin')

u = User.new(
  name: 'Moderator User',
  email: 'moderator@gmail.com', 
  password: 'bloccit1', 
  password_confirmation: 'bloccit1')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'moderator')

u = User.new(
  name: 'Member User',
  email: 'member@gmail.com', 
  password: 'bloccit1', 
  password_confirmation: 'bloccit1')
u.skip_confirmation!
u.save


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"

