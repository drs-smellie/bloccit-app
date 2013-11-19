class Topic < ActiveRecord::Base
    has_many :posts
    default_scope order('created_at DESC')
end
