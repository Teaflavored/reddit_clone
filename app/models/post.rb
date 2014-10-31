# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :url, :author, presence: true
  
  has_many :postsubs, inverse_of: :post
  
  has_many(
    :top_level_comments,
    -> { where('comments.parent_comment_id IS NULL') },
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id
  )
  
  has_many(
    :subs,
    through: :postsubs,
    source: :sub
  )
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
    
  has_many :comments
  
  def comments_by_parent_id
    results = Hash.new([])
    comments.includes(:author).each do |comment|
      results[comment.parent_comment_id] += [comment]
    end
    results
  end
end
