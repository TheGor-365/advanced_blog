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

elapsed = Benchmark.measure do
  posts = []

  gor = User.first
  eric = User.second

  1000.times do |post_number|
    puts "Creating post #{post_number}"

    post = Post.new(
      title: "Title #{post_number}",
      body: "Body for post with title: Title #{post_number}",
      user: gor
    )

    10.times do |comment_number|
      puts "Creating comment #{comment_number} for post #{post_number}"

      post.comments.build(
        body: "Comment #{comment_number}",
        user: eric
      )

    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)
end

puts
puts "Created #{Post.all.count} posts and #{Comment.all.count} comments in #{elapsed.real} seconds"
