User.create(
  email: "gor@gor.com",
  name: "Gor",
  role: User.roles[:admin],
  password: 'password',
  password_confirmation: 'password'
)

User.create(
  email: "eric@eric.com",
  name: "Eric",
  role: User.roles[:user],
  password: 'password',
  password_confirmation: 'password'
)

10.times do |post_number|
  post = Post.create(
    title: "Title #{post_number}",
    body: "Body for post with title: Title #{post_number}",
    user_id: rand(User.first.id..User.last.id)
  )

  5.times do |comment_number|
    Comment.create(
      body: "Comment #{comment_number}",
      user_id: User.second.id,
      post_id: post.id
    )
  end
end
