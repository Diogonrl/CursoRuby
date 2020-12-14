class Post < ApplicationRecord
    validates :name, presence: true 
    validates :description, presence: true, length: {minimum:35, maximum:500}
    belongs_to :user
    validates :user_id, presence: true
end