class PostSerializer < ActiveModel::Serializer
  attributes :id, :likes, :text_content, :alias_name

  def alias_name
    User.find(object["user_id"])["alias_name"]
  end
end
