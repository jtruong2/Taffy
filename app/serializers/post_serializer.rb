class PostSerializer < ActiveModel::Serializer
  attributes :id,:likes, :text_content, :alias_name

  def alias_name
    User.find(object["user_id"])["alias_name"]
  end

  def likes
    Like.where(post_id: object['id']).count
  end
end
