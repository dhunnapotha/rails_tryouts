class Member < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :gc_users, :class => "User", :foreign_key => "member_id"
end


class User
  belongs_to :member

end


create_table :patients do |t|
  t.string :name, index: true
  t.timestamps null: false
end

# ---------> xref - many-many relationships

class Assembly < ActiveRecord::Base
  has_and_belongs_to_many :parts
end
 
class Part < ActiveRecord::Base
  has_and_belongs_to_many :assemblies
end

# This is nothing but a many-to-many relationship. 

# The migration should crate 3 tabls: given below

  create_table :assemblies do |t|
    t.string :name
    t.timestamps null: false
  end

  create_table :parts do |t|
    t.string :part_number
    t.timestamps null: false
  end

  create_table :assemblies_parts, id: false do |t|
    t.belongs_to :assembly, index: true
    t.belongs_to :part, index: true
  end


# Which can also be achieved with has_many and through but by defining a class for the xref for eg: 
# class Manifest < ActiveRecord::Base
#   belongs_to :assembly
#   belongs_to :part
# end

# It is upto the user. If Manifest objects are expected to be handled independently, it is better to go through has_many and through, otherwise it is better to go via has_and_belongs_to_many



# POLYMORPHISM
# A model can belong to multiple models with a single belongs to
class Picture
  belongs_to :imageable, :polymorphism => true #crate imageable_id and imageable_type in table
end

class User
  has_one :picture, :as => :imageable
end

class Product
  has_one :picture, as: :imageable
end

create_table :pictures do |t|
  t.string  :name
  t.integer :imageable_id
  t.string  :imageable_type
  t.timestamps null: false
end
# A similar thing can be achieved by using STI - ie., by defining classes like UserPicture and ProductPicture and associating them to users and products. But it is a waste of code if there is no major functionaly specific to ProductPicture or UserPicture



# SELF JOIN - simple case
class Employee
  has_many :subordinates, :class => "Employee", :foreign_key => "manager_id"
  belongs_to :manager, :class => "Employee"
end

# Self joins in case of previous company
class Program < BaseProgram
  belongs_to :organization, :foreign_key => "parent_id", :class_name => "Organization"
end

class Organization < BaseProgram
  has_many :programs, :foreign_key => "parent_id", :dependent => :destroy, :class_name => "Program"
end

create_table :base_programs do |t|
  t.string :type
  t.integer :parent_id
end

# CACHING
customer.orders                 # retrieves orders from the database
customer.orders.size            # uses the cached copy of orders
customer.orders(true).empty?    # discards the cached copy of orders
                                # and goes back to the database



# INVERSE OF
class Customer < ActiveRecord::Base
  has_many :orders, :inverse_of => :customer
end
 
class Order < ActiveRecord::Base
  belongs_to :customer, :inverse_of => :orders
end

c = Customer.first
o = c.orders.first

c.first_name == o.customer.first_name # => true
c.first_name = 'Manny'
c.first_name == o.customer.first_name # => true (If there had been no inverse of, this would have been false, as o.customer would have been loaded as a different variable)

# INVERSE OF do not work in the below cases

#     They do not work with :through associations.
#     They do not work with :polymorphic associations.
#     They do not work with :as associations.
#     For belongs_to associations, has_many inverse associations are ignored.




# BUILD
customer.buid_order({})
# basically sets the foreign_key in the new order object created

# OTHERS
# eager loading and defining in association itself

class LineItem < ActiveRecord::Base
  belongs_to :order, -> { includes :customer }
end