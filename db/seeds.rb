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

posts = []
comments = []

elapsed = Benchmark.measure do
  100.times do |post_number|
    puts "Creating post #{post_number}"

    post = Post.new(
      title: "Title #{post_number}",
      body: "Body for post with title: Title #{post_number}",
      user_id: User.first.id
    )

    posts.push(post)

    2.times do |comment_number|
      puts "Creating comment #{comment_number} for post #{post_number}"

      comment = Comment.new(
        body: "Comment #{comment_number}",
        user_id: User.second.id,
        post_id: post.id
      )

      comments.push(comment)
    end
  end
end

Post.import(posts)
Comment.import(comments)

puts
puts "Created #{Post.all.count} posts and #{Comment.all.count} comments in #{elapsed.real} seconds"
