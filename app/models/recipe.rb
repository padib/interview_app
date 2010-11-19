class Recipe < ActiveRecord::Base
  attr_accessible :instructions, :title, :num_served, :ingredients
  
  belongs_to :user
  
  validates :num_served, :presence => true
  validates :title, :presence => true,
                    :length => { :maximum => 15, :minimum => 4}
  validates :ingredients, :presence => true
  validates :instructions, :presence => true,
                           :length => { :maximum => 512 }
  validates :user_id, :presence => true
  
  default_scope :order => 'recipes.created_at DESC'
  
  
end
