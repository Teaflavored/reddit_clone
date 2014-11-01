module Voteable
  extend ActiveSupport::Concern
  
  included do 
    #all this stuff run from class scope!
    has_many :votes, as: :voteable  
  end

  #methods at the root here will become instance methods
  def sing
    puts "I LOVE VOTING LALALALA"
  end
  
  #these become class methods
  module ClassMethods
    def order_by_score
      self.select(<<-SQL)
        #{self.to_s.downcase.pluralize}.*, COALESCE(SUM(votes.value), 0) 
      AS 
        sum
      SQL
      .joins(<<-SQL)
      LEFT OUTER JOIN 
        votes 
      ON 
        votes.voteable_id = #{self.to_s.downcase.pluralize}.id 
      AND 
        votes.voteable_type = '#{self}'
      SQL
      .group("#{self.to_s.downcase.pluralize}.id")
      .order("sum DESC, #{self.to_s.downcase.pluralize}.created_at DESC")
    end    
  end
end