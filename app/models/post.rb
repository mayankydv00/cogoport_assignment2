class Post < ApplicationRecord
    belongs_to :user , foreign_key:'author' 
    has_many :comments
    validates  :author , :title ,  presence: true
end
