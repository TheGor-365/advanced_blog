10.times do |number|
  Post.create(
    title: "Title #{number}",
    body: "Body for post with title: Title #{number}"
  )
end
