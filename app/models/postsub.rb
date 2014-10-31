# == Schema Information
#
# Table name: postsubs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Postsub < ActiveRecord::Base
  validates :post, :sub, presence: true
  
  belongs_to :post, inverse_of: :postsubs
  belongs_to :sub, inverse_of: :postsubs
 
end
