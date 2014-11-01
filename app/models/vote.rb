# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  value         :integer          not null
#  voteable_id   :integer          not null
#  voteable_type :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Vote < ActiveRecord::Base
  validates :value, presence: true
  belongs_to :voteable, polymorphic: true
end
