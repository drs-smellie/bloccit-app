class Topic < ActiveRecord::Base
    has_many :posts, dependent: :destroy
    default_scope order('created_at DESC')
    scope :visible_to, lambda { |user| user ? scoped : where(public: true) }
end
