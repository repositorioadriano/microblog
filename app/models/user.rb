class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: { medium: '152x152#', thumb: '60x60#' }, default_url: "logo.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def feed
    following_ids = "SELECT following_id FROM follows
                     WHERE  follower_id = :user_id"
    Tweet.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # Ação responsável por criar um relacionamento entre usuários.
  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  # Ação responsável por destruir um relacionamento entre usuários.
  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end
end
