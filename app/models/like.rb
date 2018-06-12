class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.is_liked(user_id, post_id)
    result = where({ user_id: user_id, post_id: post_id })
    if result.empty?
      {"is_liked" => "false"}
    else
      {"is_liked" => "true"}
    end
  end
end
