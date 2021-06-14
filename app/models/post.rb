class Post < ApplicationRecord
    belongs_to :user
    has_many :likes

    validates :title, presence: true
    validates :user_id, presence: true
end
