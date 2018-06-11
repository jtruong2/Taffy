class User < ApplicationRecord
  has_secure_password
  has_many :posts

  validates_presence_of :alias_name, :email
end
