class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      name
      email
      views
      created_at
      updated_at
    ]
  end
end
