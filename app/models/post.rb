class Post < ApplicationRecord
    belongs_to :user , foreign_key:'author' 
    has_many :comments
    validates :title ,  presence: true
end
