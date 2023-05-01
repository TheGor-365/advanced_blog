class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :body, presence: true, length: { minimum: 3, maximum: 10000 }

  belongs_to :user

  after_commit :on_create

  has_many :comments, dependent: :destroy

  has_rich_text :body
  has_one :content, class_name: 'ActionText::RichText', as: :record, dependent: :destroy

  has_noticed_notifications model_name: 'Notification'
  has_many :notifications, through: :user

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      title
      content
      views
      user_id
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[
      user
      comments
      notifications
    ]
  end

  def on_create
    Post.all.each_with_index do |post, post_number|
      post.title = "#{(post_number).to_s} #{post.title}"
    end
  end
end
