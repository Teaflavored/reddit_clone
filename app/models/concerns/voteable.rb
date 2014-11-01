module Voteable
  extend ActiveSupport::Concern
  
  included do 
    has_many :votes, as: :voteable
    
    def self.order_by_score
      self.select("#{self.to_s.downcase.pluralize}.*, COALESCE(SUM(votes.value), 0) AS sum")
      .joins("LEFT OUTER JOIN votes ON votes.voteable_id = #{self.to_s.downcase.pluralize}.id AND votes.voteable_type = '#{self}'")
      .group("#{self.to_s.downcase.pluralize}.id").order("sum DESC, #{self.to_s.downcase.pluralize}.created_at DESC")
    end
    
  end
end