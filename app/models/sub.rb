# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  description  :string(255)      not null
#  moderator_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true
  
  has_many :postsubs, inverse_of: :sub
  has_many(
    :posts,
    through: :postsubs,
    source: :post
  )
  
  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id
  )
end
