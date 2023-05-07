def seed_users
  gor = User.create(
    email: "gor@gor.com",
    first_name: "Gor",
    last_name: "Developer",
    role: User.roles[:admin],
    password: 'password',
    password_confirmation: 'password'
  )

  eric = User.create(
    email: "eric@eric.com",
    first_name: "Eric",
    last_name: "Smith",
    role: User.roles[:user],
    password: 'password',
    password_confirmation: 'password'
  )
end


def seed_addresses
  Address.create(
    street: '123 Main St',
    city: 'Anytown',
    state: 'CA',
    zip: '12345',
    country: 'USA',
    user: User.first
  )

  Address.create(
    street: '128 Rain St',
    city: 'Sometown',
    state: 'CA',
    zip: '23456',
    country: 'USA',
    user: User.second
  )
end


def seed_categories
  Category.create( name: 'First category', display_in_nav: true )
  Category.create( name: 'Second category', display_in_nav: false )
  Category.create( name: 'Third category', display_in_nav: true )
  Category.create( name: 'More category', display_in_nav: true )
end


def seed_posts_and_comments
  posts = []
  gor = User.first
  eric = User.second
  category = Category.first

  10.times do |post_number|
    puts "Creating post #{post_number}"

    post = Post.new(
      title: "Title #{post_number}",
      body: "Body for post with title: Title #{post_number}",
      user: gor,
      category: category
    )

    5.times do |comment_number|
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


def seed_ahoy
  Ahoy.geocode = false

  request = OpenStruct.new(
    params:       {},
    referer:      'http://example.com',
    remote_ip:    '0.0.0.0',
    user_agent:   'Internet Explorer',
    original_url: 'rails'
  )

  visit_properties = Ahoy::VisitProperties.new(request, api: nil)
  properties = visit_properties.generate.select { |_, v| v }

  example_visit = Ahoy::Visit.create!(properties.merge(
    visit_token: SecureRandom.uuid,
    visitor_token: SecureRandom.uuid
    ))

    2.months.ago.to_date.upto(Date.today) do |date|
      Post.all.each do |post|
        rand(1..5).times do |_x|
          Ahoy::Event.create!(
            name:       'Viewed post',
            visit:      example_visit,
            properties: { post_id: post.id },
            time:       date.to_time + rand(0..23).hours + rand(0..59).minutes
          )
        end
      end
    end
end


elapsed = Benchmark.measure do
  puts 'Seeding development database...' if Rails.env.development?

  seed_users
  seed_addresses
  seed_categories
  seed_posts_and_comments
  seed_ahoy
end


puts
puts "Created #{Post.all.count} posts and #{Comment.all.count} comments in #{elapsed.real} seconds"
