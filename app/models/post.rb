class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :body, presence: true, length: { minimum: 3, maximum: 500 }

  after_commit :on_create

  def on_create
    Post.all.each_with_index do |post, post_number|
      post.title = "#{(post_number).to_s} #{post.title}"
    end
  end
end
