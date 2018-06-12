class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :likes

  validates_presence_of :alias_name, :email
end
