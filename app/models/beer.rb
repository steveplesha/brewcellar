class Beer < ActiveRecord::Base
    belongs_to :user
    
    scope :contains, ->(name) { where("name like ?", "#{name}%")}
end
