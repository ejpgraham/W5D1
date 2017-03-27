class Post < ApplicationRecord
  validates :title, :author, presence: true

  has_many(
    :post_subs,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: "PostSub",
    inverse_of: :post
  )

  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )

  belongs_to(
    :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "User"
  )

  has_many :comments

  def comments_by_parent_id
    comments = Hash.new { |h, k| h[k] = [] }

    self.comments.each do |comment|
      comments[comment.parent_comment_id] << comment
    end

    comments
  end
end
