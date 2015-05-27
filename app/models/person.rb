class Person < ActiveRecord::Base
  has_many :children, :class_name => "Person", :foreign_key => "person_id" 
end
