class Task < ActiveRecord::Base
  belongs_to :project, touch: true
end
