class User < ActiveRecord::Base

  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  sluggable_column :username

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}


  def admin?
    self.role == "admin"
  end
  
  def moderator?
    self.role == "moderator"
  end

end