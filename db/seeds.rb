User.create(
  email: "gor@gor.com",
  password: 'password',
  password_confirmation: 'password'
)

10.times do |number|
  Post.create(
    title: "Title #{number}",
    body: "Body for post with title: Title #{number}",
    user_id: User.first.id
  )
end
