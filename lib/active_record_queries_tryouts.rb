
find_each - default size 1000 - yield to individual records
options: batch_size, start


find_in_batches - yields to multiple records
.where("first_name = ?", params[:first_name])

pluck - returns an array!

group - Member.select("date(created_at) as datetime").group("date(created_at)") - returns a single member object for each date
if want to get the count then

having - define conditions on group clause - Member.group("organization_id").having("count(organization_id) > 30").count

joins - Member.joins(:users), Member.joins(:users, :notifications)

# SQL 
# inner join - the overlapping part
# left outer join - the whole of left table
# right outer join - the whole of right table


class Category
  has_many :articles
  has_many :tags
end

class Article
  has_many :comments
  belongs_to :category
  has_many :tags
end

class Comments
  has_one :guest
  belongs_to :article
end



# Article which has atleast one comment
Article.joins(:comments)

# Article which belongs a category and atleast one comment
Article.joins(:category, :comments)


# Article which has atleast one comment from guest
Article.joins(:comments => {:guest})

# Category which has atleast one article
Category.joins(:articles)

# Category which has atleast one article with a comment
Category.joins(:articles => {:comments})

# Category which has atlest one article with a comment made by a guest
Category.joins(:articles => {:comments => {:guest}})

# Category which has atleast one article with a comment made by a guest AND atleast one tag attached to the category
Category.joins(:articles => {:comments => {:guest}}, :tags)

# Category which has atleast one article with a comment made by a guest AND atleast one tag attached to the article
Category.joins(:articles => [{:comment => {:guest}}, :tags])
# Eager loading follows a similar syntax as that of joins.




# scopes
class Member
  # different ways to define scopes
  scope :gc_admins, :conditions => {:admin => true}
  scope :gc_admins_lambda_way, ->{where(:admin => true)}
  scope :gc_admins_lambda_conditions_way, ->{{:conditions => {:admin => true}}}
  scope :gc_created_after, ->(input){where("created_at > ?", input)}
  scope :gc_created_after_simple_lambda, lambda { |input| where("created_at > ?", input)}
end


# write your own sql queries if you want
Member.find_by_sql("select * from members where members.admin = true ")

# nested conditions in sql
Member.joins(:users).where(:users => {:state => 'active'})

#use explain to get information about SQL query
Member.joins(:users).where(:users => {:state => 'active'})