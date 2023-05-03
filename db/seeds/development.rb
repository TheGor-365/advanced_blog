puts 'Seeding development database...' if Rails.env.development?


gor = User.first_or_create!(
  email: "gor@gor.com",
  first_name: "Gor",
  last_name: "Developer",
  role: User.roles[:admin],
  password: 'password',
  password_confirmation: 'password'
)

eric = User.first_or_create!(
  email: "eric@eric.com",
  first_name: "Eric",
  last_name: "Smith",
  role: User.roles[:user],
  password: 'password',
  password_confirmation: 'password'
)


Address.first_or_create!(
  street: '123 Main St',
  city: 'Anytown',
  state: 'CA',
  zip: '12345',
  country: 'USA',
  user: gor
)

Address.first_or_create!(
  street: '128 Rain St',
  city: 'Sometown',
  state: 'CA',
  zip: '23456',
  country: 'USA',
  user: eric
)


elapsed = Benchmark.measure do
  posts = []

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
